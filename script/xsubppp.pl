#!/usr/bin/perl -w
#############################################################################
## Name:        script/xsubppp.pl
## Purpose:     XS++ preprocessor
## Author:      Mattia Barbon
## Modified by:
## Created:     01/03/2003
## RCS-ID:      $Id: xsubppp.pl,v 1.8 2004/12/21 20:57:45 mbarbon Exp $
## Copyright:   (c) 2003-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use FindBin;
use lib $FindBin::RealBin;
use Carp;

=head1 NAME

XSP - XS++ preprocessor

=head1 DOCUMENTATION

See C<XSpp.pod> in the wxPerl distribution.

=cut

package XSP::Parser;

use XSP;

=head1 XSP::Parser METHODS

=cut

sub _my_open {
  my $file = shift;
  local *IN;

  open IN, "< $file" or die "open '$file': $!";

  return *IN;
}

=head2 XSP::Parser::new( file => path )

Create a new XS++ parser.

=cut

sub new {
  my $ref = shift;
  my $class = ref $ref || $ref;
  my $this = bless {}, $class;
  my %args = @_;

  $this->{FILE} = $args{file};
  $this->{PARSER} = XSP->new;

  return $this;
}

=head2 XSP::Parser::parse

Parse the file data; returns true on success, false otherwise,
on failure C<get_errors> will return the list of errors.

=cut

sub parse {
  my $this = shift;
  my $fh = _my_open( $this->{FILE} );
  my $buf = '';

  my $parser = $this->{PARSER};
  $parser->YYData->{LEX}{FH} = $fh;
  $parser->YYData->{LEX}{BUFFER} = \$buf;

  $this->{DATA} = $parser->YYParse( yylex   => \&XSP::yylex,
                                    yyerror => \&XSP::yyerror,
                                    yydebug => 0,
                                   );
}

=head2 XSP::Parser::get_data

Returns a list containing the parsed data. Each item of the list is
a subclass of C<XSP::Parser::Thing>

=cut

sub get_data {
  my $this = shift;
  die "'parse' must be called before calling 'get_data'"
    unless exists $this->{DATA};

  return $this->{DATA};
}

=head2 XSP::Parser::get_errors

Returns the parsing errors as an array.

=cut

sub get_errors {
  my $this = shift;

  return @{$this->{ERRORS}};
}

package XSP::Parser::Thing;

=head1 XSP::Parser::Thing

Base class for the parser output.

=cut

sub new {
  my $ref = shift;
  my $class = ref $ref || $ref;
  my $this = bless {}, $class;

  $this->init( @_ );

  return $this;
}

=head2 XSP::Parser::Thing::print

Return a string to be output in the final XS file.
Every class must override this method.

=cut

package XSP::Parser::Raw;

=head1 XSP::Parser::Raw

Contains data that should be output "as is" in the destination file.

=cut

use base 'XSP::Parser::Thing';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{ROWS} = $args{rows};
}

=head2 XSP::Parser::Raw::rows

Returns an array reference holding the rows to be output in the final file.

=cut

sub rows { $_[0]->{ROWS} }
sub print { join( "\n", @{$_[0]->rows} ) . "\n" }

package XSP::Parser::Class;

=head1 XSP::Parser::Class

A class.

=cut

use base 'XSP::Parser::Thing';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{CPP_NAME} = $args{cpp_name};
  $this->{PERL_NAME} = $args{perl_name} || $args{cpp_name};
  $this->{METHODS} = $args{methods} || [];
}

=head2 XSP::Parser::Class::cpp_name

Returns the C++ name for the class.

=cut

=head2 XSP::Parser::Class::perl_name

Returns the Perl name for the class.

=head2 XSP::Parser::Class::methods

=cut

sub cpp_name { $_[0]->{CPP_NAME} }
sub perl_name { $_[0]->{PERL_NAME} }
sub methods { $_[0]->{METHODS} }

sub print {
  my $this = shift;
  my $state = shift;
  my $out = '';
  my $pcname = $this->perl_name;

  if( !defined $state->{current_module} ) {
    die "No current module: remember to add a %module{} directive";
  }
  my $cur_module = $state->{current_module}->to_string;

  $out .= <<EOT;

$cur_module PACKAGE=$pcname

EOT

  foreach my $m ( @{$this->methods} ) {
    $out .= $m->print;
  }

  return $out;
}

package XSP::Parser::Function;

use base 'XSP::Parser::Thing';

=head1 XSP::Parser::Function

A function; this is also a base class for C<Method>.

=cut

sub init {
  my $this = shift;
  my %args = @_;

  $this->{CPP_NAME} = $args{cpp_name};
  $this->{PERL_NAME} = $args{perl_name} || $args{cpp_name};
  $this->{ARGUMENTS} = $args{arguments} || [];
  $this->{RET_TYPE} = $args{ret_type};
  $this->{CODE} = $args{code};
}

=head2 XSP::Parser::Function::cpp_name

=head2 XSP::Parser::Function::perl_name

=head2 XSP::Parser::Function::arguments

=head2 XSP::Parser::Function::ret_type

=head2 XSP::Parser::Function::code

=cut

sub cpp_name { $_[0]->{CPP_NAME} }
sub perl_name { $_[0]->{PERL_NAME} }
sub arguments { $_[0]->{ARGUMENTS} }
sub ret_type { $_[0]->{RET_TYPE} }
sub code { $_[0]->{CODE} }

#
# return_type
# class_name::function_name( args = def, ... )
#     type arg
#     type arg
#   PREINIT:
#     aux vars
#   [PP]CODE:
#     RETVAL = new Foo( THIS->method( arg1, *arg2 ) );
#   OUTPUT:
#     RETVAL
sub print {
  my $this = shift;
  my $out = '';
  my $fname = $this->perl_function_name;
  my $args = $this->arguments;
  my $ret_type = $this->ret_type;
  my @typemaps;
  my $ret_typemap = $ret_type ?
    XSP::typemap::get_typemap_for_type( $ret_type ) : undef;
  my $need_call_function = 0;
  my $init = '';
  my $arg_list = '';
  my $call_arg_list = '';
  my $code = '';
  my $output = '';

  if( $args ) {
    # construct typemaps for arguments, and check if some of them require
    # "complex" treatment
    foreach my $a ( @$args ) {
      my $t = XSP::typemap::get_typemap_for_type( $a->type );
      push @typemaps, $t;
      $need_call_function ||= defined $t->call_parameter_code( '' );
    }

    foreach my $i ( 0 .. $#$args ) {
      my $a = ${$args}[$i];
      my $t = $typemaps[$i];

      $arg_list .= ', ' . $a->name;
      $arg_list .= ' = ' . $a->default if $a->has_default;
      $init .= '    ' . $t->cpp_type . ' ' . $a->name . "\n";

      my $call_code = $t->call_parameter_code( $a->name );
      $call_arg_list .= ', ' . ( defined( $call_code ) ?
                                            $call_code :
                                            $a->name );
    }

    $arg_list = substr( $arg_list, 1 ) . ' ' if length $arg_list;
    $call_arg_list = substr( $call_arg_list, 1 ) . ' '
      if length $call_arg_list;
  }
  # same for return value
  $need_call_function ||= $ret_typemap &&
    defined $ret_typemap->call_function_code( '', '' );
  # is C++ name != Perl name?
  $need_call_function ||= $this->cpp_name ne $this->perl_name;

  my $retstr = $ret_typemap ? $ret_typemap->cpp_type : 'void';

  # specila case: constructors with name different from 'new'
  # need to be declared 'static' in XS
  if( $this->isa( 'XSP::Parser::Constructor' ) &&
      $this->perl_name ne $this->cpp_name ) {
    $retstr = "static $retstr";
  }

  if( $need_call_function ) {
    my $has_ret = $ret_typemap && !$ret_typemap->type->is_void;
    my $ccode = $this->_call_code( $call_arg_list );
    if( $has_ret && defined $ret_typemap->call_function_code( '', '' ) ) {
      $ccode = $ret_typemap->call_function_code( $ccode, 'RETVAL' );
    } elsif( $has_ret ) {
      $ccode = "RETVAL = $ccode";
    }

    $code .= "  CODE:\n";
    $code .= '    ' . $ccode . ";\n";

    $output = "  OUTPUT: RETVAL\n" if $has_ret;
  }

  if( $this->code ) {
    $code = "  CODE:\n    " . join( "\n", @{$this->code} ) . "\n";
    $output = "  OUTPUT: RETVAL\n" if $code =~ m/RETVAL/;
  }

  $out .= "$retstr\n";
  $out .= "$fname($arg_list)\n";
  $out .= $init;
  $out .= $code;
  $out .= $output;
  $out .= "\n";
}

sub perl_function_name { $_[0]->perl_name }

=begin documentation

XSP::Parser::_call_code( argument_string )

Return something like "foo( $argument_string )".

=end documentation

=cut

sub _call_code { die 'IMPLEMENT ME' }

package XSP::Parser::Method;

use base 'XSP::Parser::Function';

sub class { $_[0]->{CLASS} }
sub perl_function_name { $_[0]->class->cpp_name . '::' .
                         $_[0]->perl_name }
sub _call_code { return "THIS->" . $_[0]->cpp_name .
                   '(' . $_[1] . ')'; }

package XSP::Parser::Constructor;

use base 'XSP::Parser::Method';

sub init {
  my $this = shift;
  $this->SUPER::init( @_ );

  die "Can't specify return value in constructor" if $this->{RET_TYPE};
}

sub ret_type {
  my $this = shift;

  XSP::Parser::Type->new( base      => $this->class->cpp_name,
                          pointer   => 1 );
}

sub perl_function_name {
  my $this = shift;
  my( $pname, $cname, $pclass, $cclass ) = ( $this->perl_name,
                                             $this->cpp_name,
                                             $this->class->perl_name,
                                             $this->class->cpp_name );

  if( $pname ne $cname ) {
    return $cclass . '::' . $pname;
  } else {
    return $cclass . '::' . 'new';
  }
}

sub _call_code { return "new " . $_[0]->class->cpp_name .
                   '(' . $_[1] . ')'; }

package XSP::Parser::Destructor;

use base 'XSP::Parser::Method';

sub init {
  my $this = shift;
  $this->SUPER::init( @_ );

  die "Can't specify return value in destructor" if $this->{RET_TYPE};
}

sub perl_function_name { $_[0]->class->cpp_name . '::' . 'DESTROY' }

package XSP::Parser::Argument;

use base 'XSP::Parser::Thing';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{TYPE} = $args{type};
  $this->{NAME} = $args{name};
  $this->{DEFAULT} = $args{default};
}

sub print {
  my $this = shift;

  return join( ' ',
               $this->type->print,
               $this->name,
               ( $this->default ?
                 ( '=', $this->default ) : () ) );
}

sub type { $_[0]->{TYPE} }
sub name { $_[0]->{NAME} }
sub default { $_[0]->{DEFAULT} }
sub has_default { defined $_[0]->{DEFAULT} }

package XSP::Parser::Type;

use base 'XSP::Parser::Thing';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{BASE} = $args{base};
  $this->{POINTER} = $args{pointer} ? 1 : 0;
  $this->{REFERENCE} = $args{reference} ? 1 : 0;
  $this->{CONST} = $args{const} ? 1 : 0;
}

sub is_const { $_[0]->{CONST} }
sub is_reference { $_[0]->{REFERENCE} }
sub is_pointer { $_[0]->{POINTER} }
sub base_type { $_[0]->{BASE} }

sub equals {
  my( $f, $s ) = @_;

  return $f->is_const == $s->is_const
      && $f->is_reference == $s->is_reference
      && $f->is_pointer == $s->is_pointer
      && $f->base_type eq $s->base_type;
}

sub is_void { return $_[0]->base_type eq 'void' &&
                !$_[0]->is_pointer && !$_[0]->is_reference }

sub print_noconst {
  my $this = shift;

  return join( '',
               $this->base_type,
               ( $this->is_pointer ? '*' :
                 $this->is_reference ? '&' : '' ) );
}

sub print {
  my $this = shift;

  return join( '',
               ( $this->is_const ? 'const ' : '' ),
               $this->base_type,
               ( $this->is_pointer ? '*' :
                 $this->is_reference ? '&' : '' ) );
}

package XSP::Parser::Module;

use base 'XSP::Parser::Thing';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{MODULE} = $args{module};
}

sub module { $_[0]->{MODULE} }
sub to_string { 'MODULE=' . $_[0]->module }
sub print { "\n" }

package XSP::Parser::File;

use base 'XSP::Parser::Thing';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{FILE} = $args{file};
}

sub file { $_[0]->{FILE} }
sub print { "\n" }

package XSP::typemap;

=head1 XSP::typemap

=cut

sub new {
  my $ref = shift;
  my $class = ref $ref || $ref;
  my $this = bless {}, $class;

  $this->init( @_ );

  return $this;
}

=head2 XSP::typemap::type

Returns the XSP::Parser::Type that is used for this typemap.

=cut

sub type { $_[0]->{TYPE} }

=head2 XSP::typemap::cpp_type()

Returns the C++ type to be used for the local variable declaration.

=head2 XSP::typemap::input_code( perl_argument_name, cpp_var_name1, ... )

Code to put the contents of the perl_argument (typically ST(x)) into
the C++ variable(s).

=head2 XSP::typemap::output_code()

=head2 XSP::typemap::call_parameter_code( parameter_name )

=head2 XSP::typemap::call_function_code( function_call_code, return_variable )

=cut

sub init { }

sub cpp_type { die; }
sub input_code { die; }
sub output_code { }
sub call_parameter_code { }
sub call_function_code { }

my @typemaps;

sub add_typemap_for_type {
  my( $type, $typemap ) = @_;

  push @typemaps, [ $type, $typemap ];
}

sub get_typemap_for_type {
  my $type = shift;

  foreach my $t ( @typemaps ) {
    return ${$t}[1] if $t->[0]->equals( $type );
  }

  die "No typemap for type ", $type->print;
  if( $type->is_reference ) {
    return XSP::typemap::reference->new( type => $type );
  } else {
    return XSP::typemap::simple->new( type => $type );
  }
}

package XSP::typemap::parsed;

use base 'XSP::typemap';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{TYPE} = $args{type};
  $this->{CPP_TYPE} = $args{cpp_type} || $args{arg1};
  $this->{CALL_FUNCTION_CODE} = $args{call_function_code} || $args{arg2};
}

sub cpp_type { $_[0]->{CPP_TYPE} }
sub input_code { undef }
sub output_code { }
sub call_parameter_code { }
sub call_function_code {
  my $this = shift;
  my( $func, $var ) = @_;
  return unless defined $this->{CALL_FUNCTION_CODE};
  my $code = $this->{CALL_FUNCTION_CODE};

  $code =~ s/\$1/$func/g;
  $code =~ s/\$\$/$var/g;

  $code;
}

package XSP::typemap::simple;

use base 'XSP::typemap';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{TYPE} = $args{type};
}

sub cpp_type { $_[0]->{TYPE}->print_noconst }
sub input_code { undef } # simple typemap: arguments are handled by XSUBPP
sub output_code { undef } # likewise
sub call_parameter_code { undef }
sub call_function_code { undef }

package XSP::typemap::reference;

use base 'XSP::typemap';

sub init {
  my $this = shift;
  my %args = @_;

  $this->{TYPE} = $args{type};
}

sub cpp_type { $_[0]->{TYPE}->base_type . '*' }
sub imput_code { "" }
sub output_code { "" }
sub call_parameter_code { "*( $_[1] )" }
sub call_function_code {
  $_[2] . ' = new ' . $_[0]->type->base_type . '( ' . $_[1] . " )";
}

package main;

use strict;
use IO::File;
use Getopt::Long;
use File::Spec::Unix;
use File::Path ();

my @typemap_files;

GetOptions( 'typemap=s' => \@typemap_files );

foreach my $t ( @typemap_files ) {
  XSP::Parser->new( file => $t )->parse;
}

my $file = shift;
my $parser = XSP::Parser->new( file => $file );

$parser->parse;
my %out = emit_code( $parser->get_data );
print $out{'-'};

foreach my $f ( keys %out ) {
  next if $f eq '-';
  my $fh = IO::File->new;

  my( $vol, $dir, $file ) = File::Spec::Unix->splitpath( $f );
  my $d = File::Spec::Unix->catpath( $vol, $dir, '' );

  unless( -d $d ) {
    File::Path::mkpath( $d ) or die "mkpath '$d': $!";
  }

  $fh->open( "> $f" ) or die "open '$f': $!";
  binmode $fh;
  $fh->print( $out{$f} );
  $fh->close;
}

sub emit_code {
  my $data = shift;
  my %out;
  my $out_file = '-';
  my %state = ( current_module => undef );

  foreach my $e ( @$data ) {
    if( $e->isa( 'XSP::Parser::Module' ) ) { $state{current_module} = $e }
    if( $e->isa( 'XSP::Parser::File' ) ) { $out_file = $e->file }
    $out{$out_file} .= $e->print( \%state );
  }

  return %out;
}

exit 0;

# local variables:
# mode: cperl
# end:
