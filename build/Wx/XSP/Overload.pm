package build::Wx::XSP::Overload;

use strict;
use warnings;

sub new { return bless {}, $_[0] }

sub register_plugin {
    my( $class, $parser ) = @_;

    $parser->add_post_process_plugin( plugin => $class->new );
}

sub post_process {
    my( $self, $nodes ) = @_;

    foreach my $node ( @$nodes ) {
        next unless $node->isa( 'ExtUtils::XSpp::Node::Class' );
        my %all_methods;

        foreach my $method ( @{$node->methods} ) {
            next unless $method->isa( 'ExtUtils::XSpp::Node::Method' );
            next if $method->cpp_name ne $method->perl_name;
            push @{$all_methods{$method->cpp_name} ||= []}, $method;
        }

        my @ovl_methods = grep { @{$all_methods{$_}} > 1 }
                               keys %all_methods;

        foreach my $method_name ( @ovl_methods ) {
            _add_overload( $self, $node, $all_methods{$method_name} );
        }
    }
}

=pod

void
wxCaret::Move( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wpoi, MovePoint )
        MATCH_REDISP( wxPliOvl_n_n, MoveXY )
    END_OVERLOAD( Wx::Caret::Move )

=cut

sub is_bool {
    my( $type ) = @_;
    return 0 if $type->is_pointer;

    return $type->base_type eq 'bool';
}

sub is_string {
    my( $type ) = @_;
    return 1 if $type->base_type eq 'char' && $type->is_pointer == 1;
    return 1 if $type->base_type eq 'wxChar' && $type->is_pointer == 1;
    return 0 if $type->is_pointer;

    return $type->base_type eq 'wxString';
}

sub is_number {
    my( $type ) = @_;
    return 0 if $type->is_pointer;

    return grep $type->base_type eq $_,
                ( 'int', 'unsigned', 'short', 'long',
                  'unsigned int', 'unsigned short',
                  'unsigned long', 'float', 'double',
                  'wxAlignment' );
}

sub is_value {
    my( $type, $class ) = @_;
    return 0 if $type->is_pointer;

    return $type->base_type eq $class;
}

sub _compare_function {
    my( $ca, $cb ) = ( 0, 0 );

    $ca += 1 foreach grep !$_->has_default, @{$a->arguments};
    $cb += 1 foreach grep !$_->has_default, @{$b->arguments};

    return $ca - $cb if $ca != $cb;

    for( my $i = 0; $i < 10000; ++$i ) {
        return -1 if $#{$a->arguments} <  $i && $#{$b->arguments} >= $i;
        return  1 if $#{$a->arguments} >= $i && $#{$b->arguments}  < $i;
        return  0 if $#{$a->arguments} <  $i && $#{$b->arguments}  < $i;

        my $ta = $a->arguments->[$i]->type;
        my $tb = $b->arguments->[$i]->type;

        return -1 if  is_number( $ta ) && !is_number( $tb );
        return  1 if !is_number( $ta ) &&  is_number( $tb );
    }

    return 0;
}

sub _make_dispatch {
    my( $self, $methods, $method ) = @_;

    if( $method->cpp_name eq $method->perl_name ) {
        for( my $i = 0; $i < @$methods; ++$i ) {
            if( $method == $methods->[$i] ) {
                $method->{PERL_NAME} = $method->cpp_name . $i;
                last;
            }
        }
    }
    if( @{$method->arguments} == 0 ) {
        return [ undef,
                 sprintf '        MATCH_VOIDM_REDISP( %s )',
                         $method->perl_name ];
    }
    if( @$methods == 2 && @{$methods->[0]->arguments} == 0 ) {
        return [ undef,
                 sprintf '        MATCH_ANY_REDISP( %s )',
                         $method->perl_name ];
    }
    my( $min, $max, @indices );
    foreach my $arg ( @{$method->arguments} ) {
        ++$max;
        ++$min unless defined $arg->default;

        if( is_bool( $arg->type ) ) {
            push @indices, 'wxPliOvlbool';
            next;
        }
        if( is_string( $arg->type ) ) {
            push @indices, 'wxPliOvlstr';
            next;
        }
        if( is_number( $arg->type ) ) {
            push @indices, 'wxPliOvlnum';
            next;
        }
        if( is_value( $arg->type, 'wxPoint' ) ) {
            push @indices, 'wxPliOvlwpoi';
            next;
        }
        if( is_value( $arg->type, 'wxPosition' ) ) {
            push @indices, 'wxPliOvlwpos';
            next;
        }
        if( is_value( $arg->type, 'wxSize' ) ) {
            push @indices, 'wxPliOvlwsiz';
            next;
        }
        die 'Unable to dispatch ', $arg->type->base_type
          unless $arg->type->base_type =~ /^wx/;
        push @indices, '"Wx::' . ( substr $arg->type->base_type, 2 ) . '"';
    }

    my $init = sprintf <<EOT,
    static const char *%s_types[] = { %s };
    static wxPliPrototype %s_proto( %s_types, sizeof( %s_types ) / sizeof( %s_types[0] ) );
EOT
        $method->perl_name, join( ', ', @indices ),
        $method->perl_name, $method->perl_name, $method->perl_name, $method->perl_name;

    if( $min != $max ) {
        return [ $init,
                 sprintf '        MATCH_REDISP_COUNT_ALLOWMORE( %s_proto, %s, %d )',
                         $method->perl_name, $method->perl_name, $min ];
    } else {
        return [ $init,
                 sprintf '        MATCH_REDISP( %s_proto, %s )',
                         $method->perl_name, $method->perl_name ];
    }
}

sub _add_overload {
    my( $self, $class, $methods ) = @_;
    my @methods = sort _compare_function @$methods;
    my @dispatch = map _make_dispatch( $self, $methods, $_ ), @methods;
    my $method_name = $class->cpp_name eq $methods[0]->cpp_name ?
                          'new' : $methods[0]->cpp_name;
    my $code = sprintf <<EOT,
void
%s::%s( ... )
  PPCODE:
EOT

      $class->cpp_name, $method_name;

    foreach my $dispatch ( @dispatch ) {
        next unless $dispatch->[0];
        $code .= $dispatch->[0];
    }

    $code .= <<EOT;
    BEGIN_OVERLOAD()
EOT

    foreach my $dispatch ( @dispatch ) {
        $code .= $dispatch->[1] . "\n";
    }

    $code .= sprintf <<EOT,
    END_OVERLOAD( %s::%s )
EOT
      $class->perl_name, $method_name;

    $class->add_methods( ExtUtils::XSpp::Node::Raw->new( rows => [ $code ] ) );
}

1;
