#############################################################################
## Name:        demo/wxValidator.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     15/08/2005
## RCS-ID:      $Id: wxValidator.pm,v 1.1 2005/08/15 21:44:34 mbarbon Exp $
## Copyright:   (c) 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package ValidatorDemo;

sub window {
    shift;
    my $parent = shift;

    my $window = ValidatorDemoWin->new( $parent );

    return $window;
}

sub description {
    return <<EOT;
<html>
<head>
  <title>Wx::Validator</title>
</head>
<body>
<h3>Wx::Validator</h3>

</body>
</html>
EOT
}

package ValidatorDemoWin;

use base 'Wx::Panel';
use Wx::Event qw(EVT_BUTTON);
use Wx::Perl::TextValidator;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( $_[0], -1 );

    # only allows digits
    my $numval = Wx::Perl::TextValidator->new( '\d' );
    # only allows letters
    my $charval = Wx::Perl::TextValidator->new( qr/[a-zA-z ]/ );

    Wx::StaticText->new( $self, -1, 'Type numbers', [10, 10] );
    my $t1 = Wx::TextCtrl->new( $self, -1, '', [10, 30] );
    Wx::StaticText->new( $self, -1, 'Type spaces/letters', [10, 50] );
    my $t2 = Wx::TextCtrl->new( $self, -1, '', [10, 70] );

    $t1->SetValidator( $numval );
    $t2->SetValidator( $charval );

    EVT_BUTTON( $self, Wx::Button->new( $self, -1, 'Validator and dialog', [10, 100] ),
                sub { ValidatorDemoDialog->new( $self )->ShowModal } );
    EVT_BUTTON( $self, Wx::Button->new( $self, -1, 'Validator and frame', [150, 100] ),
                sub { ValidatorDemoFrame->new( $self )->Show( 1 ) } );

    return $self;
}

package ValidatorDemoValidator;

use base qw(Wx::Perl::TextValidator);

# trivial class, just to log method calls
sub Validate {
    my $self = shift;

    Wx::LogMessage( "In Validate()" );

    return $self->SUPER::Validate( @_ );
}

sub TransferFromWindow {
    my $self = shift;

    Wx::LogMessage( "In TransferFromWindow()" );

    return $self->SUPER::TransferFromWindow( @_ );
}

sub TransferToWindow {
    my $self = shift;

    Wx::LogMessage( "In TransferToWindow()" );

    return $self->SUPER::TransferToWindow( @_ );
}

package ValidatorDemoDialog;

use Wx qw(wxID_OK wxID_CANCEL);
use base qw(Wx::Dialog);

sub new {
    my( $class, $parent ) = @_;
    my $self = $class->SUPER::new( $parent, -1, 'Dialog' );

    $self->{data} = '1234';

    # simple numeric validator
    my $numval = ValidatorDemoValidator->new( '\d', \($self->{data}) );

    Wx::StaticText->new( $self, -1, 'Type numbers', [10, 10] );
    my $t1 = Wx::TextCtrl->new( $self, -1, '', [10, 30] );

    $t1->SetValidator( $numval );

    # the validation/data transfer phase are automatic for a
    # dialog where the Ok button has ID wxID_OK, otherwise
    # an explicit call to Validate/TransferDataFromWindow is required
    # when closing the dialog
    Wx::Button->new( $self, wxID_OK, "Ok", [10, 60] );
    Wx::Button->new( $self, wxID_CANCEL, "Cancel", [100, 60] );

    return $self;
}

sub get_data { $_[0]->{data} }

package ValidatorDemoFrame;

use Wx::Event qw(EVT_BUTTON);
use base qw(Wx::Frame);

sub new {
    my( $class, $parent ) = @_;
    my $self = $class->SUPER::new( $parent, -1, 'Frame' );

    $self->{data} = '12345';

    my $numval = ValidatorDemoValidator->new( '\d', \($self->{data}) );

    Wx::StaticText->new( $self, -1, 'Type numbers', [10, 10] );
    my $t1 = Wx::TextCtrl->new( $self, -1, '', [10, 30] );

    $t1->SetValidator( $numval );

    EVT_BUTTON( $self, Wx::Button->new( $self, -1, "Ok", [10, 60] ),
                sub {
                    if( !$self->Validate ) {
                        Wx::LogMessage( "Data is invalid" );
                        return;
                    }
                    if( !$self->TransferDataFromWindow ) {
                        Wx::LogMessage( "Error in data transfer" );
                        return;
                    }
                    $self->Destroy;
                } );

    EVT_BUTTON( $self, Wx::Button->new( $self, -1, "Cancel", [100, 60] ),
                sub {
                    $self->Destroy;
                } );

    $self->TransferDataToWindow;

    return $self;
}

sub get_data { $_[0]->{data} }

1;
