####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package XSP;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
#Included Parse/Yapp/Driver.pm file----------------------------------------
{
#
# Module Parse::Yapp::Driver
#
# This module is part of the Parse::Yapp package available on your
# nearest CPAN
#
# Any use of this module in a standalone parser make the included
# text under the same copyright as the Parse::Yapp module itself.
#
# This notice should remain unchanged.
#
# (c) Copyright 1998-2001 Francois Desarmenien, all rights reserved.
# (see the pod text in Parse::Yapp module for use and distribution rights)
#

package Parse::Yapp::Driver;

require 5.004;

use strict;

use vars qw ( $VERSION $COMPATIBLE $FILENAME );

$VERSION = '1.05';
$COMPATIBLE = '0.07';
$FILENAME=__FILE__;

use Carp;

#Known parameters, all starting with YY (leading YY will be discarded)
my(%params)=(YYLEX => 'CODE', 'YYERROR' => 'CODE', YYVERSION => '',
			 YYRULES => 'ARRAY', YYSTATES => 'ARRAY', YYDEBUG => '');
#Mandatory parameters
my(@params)=('LEX','RULES','STATES');

sub new {
    my($class)=shift;
	my($errst,$nberr,$token,$value,$check,$dotpos);
    my($self)={ ERROR => \&_Error,
				ERRST => \$errst,
                NBERR => \$nberr,
				TOKEN => \$token,
				VALUE => \$value,
				DOTPOS => \$dotpos,
				STACK => [],
				DEBUG => 0,
				CHECK => \$check };

	_CheckParams( [], \%params, \@_, $self );

		exists($$self{VERSION})
	and	$$self{VERSION} < $COMPATIBLE
	and	croak "Yapp driver version $VERSION ".
			  "incompatible with version $$self{VERSION}:\n".
			  "Please recompile parser module.";

        ref($class)
    and $class=ref($class);

    bless($self,$class);
}

sub YYParse {
    my($self)=shift;
    my($retval);

	_CheckParams( \@params, \%params, \@_, $self );

	if($$self{DEBUG}) {
		_DBLoad();
		$retval = eval '$self->_DBParse()';#Do not create stab entry on compile
        $@ and die $@;
	}
	else {
		$retval = $self->_Parse();
	}
    $retval
}

sub YYData {
	my($self)=shift;

		exists($$self{USER})
	or	$$self{USER}={};

	$$self{USER};
	
}

sub YYErrok {
	my($self)=shift;

	${$$self{ERRST}}=0;
    undef;
}

sub YYNberr {
	my($self)=shift;

	${$$self{NBERR}};
}

sub YYRecovering {
	my($self)=shift;

	${$$self{ERRST}} != 0;
}

sub YYAbort {
	my($self)=shift;

	${$$self{CHECK}}='ABORT';
    undef;
}

sub YYAccept {
	my($self)=shift;

	${$$self{CHECK}}='ACCEPT';
    undef;
}

sub YYError {
	my($self)=shift;

	${$$self{CHECK}}='ERROR';
    undef;
}

sub YYSemval {
	my($self)=shift;
	my($index)= $_[0] - ${$$self{DOTPOS}} - 1;

		$index < 0
	and	-$index <= @{$$self{STACK}}
	and	return $$self{STACK}[$index][1];

	undef;	#Invalid index
}

sub YYCurtok {
	my($self)=shift;

        @_
    and ${$$self{TOKEN}}=$_[0];
    ${$$self{TOKEN}};
}

sub YYCurval {
	my($self)=shift;

        @_
    and ${$$self{VALUE}}=$_[0];
    ${$$self{VALUE}};
}

sub YYExpect {
    my($self)=shift;

    keys %{$self->{STATES}[$self->{STACK}[-1][0]]{ACTIONS}}
}

sub YYLexer {
    my($self)=shift;

	$$self{LEX};
}


#################
# Private stuff #
#################


sub _CheckParams {
	my($mandatory,$checklist,$inarray,$outhash)=@_;
	my($prm,$value);
	my($prmlst)={};

	while(($prm,$value)=splice(@$inarray,0,2)) {
        $prm=uc($prm);
			exists($$checklist{$prm})
		or	croak("Unknow parameter '$prm'");
			ref($value) eq $$checklist{$prm}
		or	croak("Invalid value for parameter '$prm'");
        $prm=unpack('@2A*',$prm);
		$$outhash{$prm}=$value;
	}
	for (@$mandatory) {
			exists($$outhash{$_})
		or	croak("Missing mandatory parameter '".lc($_)."'");
	}
}

sub _Error {
	print "Parse error.\n";
}

sub _DBLoad {
	{
		no strict 'refs';

			exists(${__PACKAGE__.'::'}{_DBParse})#Already loaded ?
		and	return;
	}
	my($fname)=__FILE__;
	my(@drv);
	open(DRV,"<$fname") or die "Report this as a BUG: Cannot open $fname";
	while(<DRV>) {
                	/^\s*sub\s+_Parse\s*{\s*$/ .. /^\s*}\s*#\s*_Parse\s*$/
        	and     do {
                	s/^#DBG>//;
                	push(@drv,$_);
        	}
	}
	close(DRV);

	$drv[0]=~s/_P/_DBP/;
	eval join('',@drv);
}

#Note that for loading debugging version of the driver,
#this file will be parsed from 'sub _Parse' up to '}#_Parse' inclusive.
#So, DO NOT remove comment at end of sub !!!
sub _Parse {
    my($self)=shift;

	my($rules,$states,$lex,$error)
     = @$self{ 'RULES', 'STATES', 'LEX', 'ERROR' };
	my($errstatus,$nberror,$token,$value,$stack,$check,$dotpos)
     = @$self{ 'ERRST', 'NBERR', 'TOKEN', 'VALUE', 'STACK', 'CHECK', 'DOTPOS' };

#DBG>	my($debug)=$$self{DEBUG};
#DBG>	my($dbgerror)=0;

#DBG>	my($ShowCurToken) = sub {
#DBG>		my($tok)='>';
#DBG>		for (split('',$$token)) {
#DBG>			$tok.=		(ord($_) < 32 or ord($_) > 126)
#DBG>					?	sprintf('<%02X>',ord($_))
#DBG>					:	$_;
#DBG>		}
#DBG>		$tok.='<';
#DBG>	};

	$$errstatus=0;
	$$nberror=0;
	($$token,$$value)=(undef,undef);
	@$stack=( [ 0, undef ] );
	$$check='';

    while(1) {
        my($actions,$act,$stateno);

        $stateno=$$stack[-1][0];
        $actions=$$states[$stateno];

#DBG>	print STDERR ('-' x 40),"\n";
#DBG>		$debug & 0x2
#DBG>	and	print STDERR "In state $stateno:\n";
#DBG>		$debug & 0x08
#DBG>	and	print STDERR "Stack:[".
#DBG>					 join(',',map { $$_[0] } @$stack).
#DBG>					 "]\n";


        if  (exists($$actions{ACTIONS})) {

				defined($$token)
            or	do {
				($$token,$$value)=&$lex($self);
#DBG>				$debug & 0x01
#DBG>			and	print STDERR "Need token. Got ".&$ShowCurToken."\n";
			};

            $act=   exists($$actions{ACTIONS}{$$token})
                    ?   $$actions{ACTIONS}{$$token}
                    :   exists($$actions{DEFAULT})
                        ?   $$actions{DEFAULT}
                        :   undef;
        }
        else {
            $act=$$actions{DEFAULT};
#DBG>			$debug & 0x01
#DBG>		and	print STDERR "Don't need token.\n";
        }

            defined($act)
        and do {

                $act > 0
            and do {        #shift

#DBG>				$debug & 0x04
#DBG>			and	print STDERR "Shift and go to state $act.\n";

					$$errstatus
				and	do {
					--$$errstatus;

#DBG>					$debug & 0x10
#DBG>				and	$dbgerror
#DBG>				and	$$errstatus == 0
#DBG>				and	do {
#DBG>					print STDERR "**End of Error recovery.\n";
#DBG>					$dbgerror=0;
#DBG>				};
				};


                push(@$stack,[ $act, $$value ]);

					$$token ne ''	#Don't eat the eof
				and	$$token=$$value=undef;
                next;
            };

            #reduce
            my($lhs,$len,$code,@sempar,$semval);
            ($lhs,$len,$code)=@{$$rules[-$act]};

#DBG>			$debug & 0x04
#DBG>		and	$act
#DBG>		and	print STDERR "Reduce using rule ".-$act." ($lhs,$len): ";

                $act
            or  $self->YYAccept();

            $$dotpos=$len;

                unpack('A1',$lhs) eq '@'    #In line rule
            and do {
                    $lhs =~ /^\@[0-9]+\-([0-9]+)$/
                or  die "In line rule name '$lhs' ill formed: ".
                        "report it as a BUG.\n";
                $$dotpos = $1;
            };

            @sempar =       $$dotpos
                        ?   map { $$_[1] } @$stack[ -$$dotpos .. -1 ]
                        :   ();

            $semval = $code ? &$code( $self, @sempar )
                            : @sempar ? $sempar[0] : undef;

            splice(@$stack,-$len,$len);

                $$check eq 'ACCEPT'
            and do {

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Accept.\n";

				return($semval);
			};

                $$check eq 'ABORT'
            and	do {

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Abort.\n";

				return(undef);

			};

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Back to state $$stack[-1][0], then ";

                $$check eq 'ERROR'
            or  do {
#DBG>				$debug & 0x04
#DBG>			and	print STDERR 
#DBG>				    "go to state $$states[$$stack[-1][0]]{GOTOS}{$lhs}.\n";

#DBG>				$debug & 0x10
#DBG>			and	$dbgerror
#DBG>			and	$$errstatus == 0
#DBG>			and	do {
#DBG>				print STDERR "**End of Error recovery.\n";
#DBG>				$dbgerror=0;
#DBG>			};

			    push(@$stack,
                     [ $$states[$$stack[-1][0]]{GOTOS}{$lhs}, $semval ]);
                $$check='';
                next;
            };

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Forced Error recovery.\n";

            $$check='';

        };

        #Error
            $$errstatus
        or   do {

            $$errstatus = 1;
            &$error($self);
                $$errstatus # if 0, then YYErrok has been called
            or  next;       # so continue parsing

#DBG>			$debug & 0x10
#DBG>		and	do {
#DBG>			print STDERR "**Entering Error recovery.\n";
#DBG>			++$dbgerror;
#DBG>		};

            ++$$nberror;

        };

			$$errstatus == 3	#The next token is not valid: discard it
		and	do {
				$$token eq ''	# End of input: no hope
			and	do {
#DBG>				$debug & 0x10
#DBG>			and	print STDERR "**At eof: aborting.\n";
				return(undef);
			};

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**Dicard invalid token ".&$ShowCurToken.".\n";

			$$token=$$value=undef;
		};

        $$errstatus=3;

		while(	  @$stack
			  and (		not exists($$states[$$stack[-1][0]]{ACTIONS})
			        or  not exists($$states[$$stack[-1][0]]{ACTIONS}{error})
					or	$$states[$$stack[-1][0]]{ACTIONS}{error} <= 0)) {

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**Pop state $$stack[-1][0].\n";

			pop(@$stack);
		}

			@$stack
		or	do {

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**No state left on stack: aborting.\n";

			return(undef);
		};

		#shift the error token

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**Shift \$error token and go to state ".
#DBG>						 $$states[$$stack[-1][0]]{ACTIONS}{error}.
#DBG>						 ".\n";

		push(@$stack, [ $$states[$$stack[-1][0]]{ACTIONS}{error}, undef ]);

    }

    #never reached
	croak("Error in driver logic. Please, report it as a BUG");

}#_Parse
#DO NOT remove comment

1;

}
#End of include--------------------------------------------------




sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			'p_module' => 12,
			'p_name' => 2,
			"class" => 15,
			'RAW_CODE' => 9,
			'p_typemap' => 1,
			'p_file' => 17,
			'OPSPECIAL' => 4
		},
		GOTOS => {
			'perc_file' => 7,
			'directive' => 6,
			'top' => 8,
			'special_block' => 10,
			'typemap' => 11,
			'raw' => 13,
			'perc_name' => 14,
			'class' => 3,
			'perc_module' => 16,
			'special_block_start' => 5
		}
	},
	{#State 1
		ACTIONS => {
			'OPCURLY' => 18
		}
	},
	{#State 2
		ACTIONS => {
			'OPCURLY' => 19
		}
	},
	{#State 3
		DEFAULT => -2
	},
	{#State 4
		DEFAULT => -59
	},
	{#State 5
		ACTIONS => {
			'line' => 21
		},
		GOTOS => {
			'lines' => 20
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			'SEMICOLON' => 22
		}
	},
	{#State 8
		ACTIONS => {
			'' => 23,
			'RAW_CODE' => 9,
			'p_typemap' => 1,
			'p_name' => 2,
			'p_module' => 12,
			"class" => 15,
			'p_file' => 17,
			'OPSPECIAL' => 4
		},
		GOTOS => {
			'directive' => 25,
			'perc_file' => 7,
			'special_block' => 10,
			'typemap' => 11,
			'raw' => 26,
			'perc_name' => 14,
			'class' => 24,
			'perc_module' => 16,
			'special_block_start' => 5
		}
	},
	{#State 9
		DEFAULT => -12
	},
	{#State 10
		DEFAULT => -13
	},
	{#State 11
		ACTIONS => {
			'SEMICOLON' => 27
		}
	},
	{#State 12
		ACTIONS => {
			'OPCURLY' => 28
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			"class" => 29
		}
	},
	{#State 15
		ACTIONS => {
			'ID' => 30
		}
	},
	{#State 16
		ACTIONS => {
			'SEMICOLON' => 31
		}
	},
	{#State 17
		ACTIONS => {
			'OPCURLY' => 32
		}
	},
	{#State 18
		ACTIONS => {
			"const" => 33,
			'ID' => 35
		},
		GOTOS => {
			'class_name' => 36,
			'type' => 34
		}
	},
	{#State 19
		ACTIONS => {
			'ID' => 35
		},
		GOTOS => {
			'class_name' => 37
		}
	},
	{#State 20
		ACTIONS => {
			'line' => 39,
			'CLSPECIAL' => 38
		},
		GOTOS => {
			'special_block_end' => 40
		}
	},
	{#State 21
		DEFAULT => -61
	},
	{#State 22
		DEFAULT => -8
	},
	{#State 23
		DEFAULT => 0
	},
	{#State 24
		DEFAULT => -5
	},
	{#State 25
		DEFAULT => -6
	},
	{#State 26
		DEFAULT => -4
	},
	{#State 27
		DEFAULT => -9
	},
	{#State 28
		ACTIONS => {
			'ID' => 35
		},
		GOTOS => {
			'class_name' => 41
		}
	},
	{#State 29
		ACTIONS => {
			'ID' => 42
		}
	},
	{#State 30
		ACTIONS => {
			'OPCURLY' => 43
		}
	},
	{#State 31
		DEFAULT => -7
	},
	{#State 32
		ACTIONS => {
			'ID' => 46,
			'DASH' => 45
		},
		GOTOS => {
			'file_name' => 44
		}
	},
	{#State 33
		ACTIONS => {
			'ID' => 35
		},
		GOTOS => {
			'class_name' => 47
		}
	},
	{#State 34
		ACTIONS => {
			'CLCURLY' => 48
		}
	},
	{#State 35
		ACTIONS => {
			'DCOLON' => 49
		},
		DEFAULT => -43
	},
	{#State 36
		ACTIONS => {
			'AMP' => 51,
			'STAR' => 50
		},
		DEFAULT => -42
	},
	{#State 37
		ACTIONS => {
			'CLCURLY' => 52
		}
	},
	{#State 38
		DEFAULT => -60
	},
	{#State 39
		DEFAULT => -62
	},
	{#State 40
		DEFAULT => -58
	},
	{#State 41
		ACTIONS => {
			'CLCURLY' => 53
		}
	},
	{#State 42
		ACTIONS => {
			'OPCURLY' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'p_name' => 2,
			"const" => 33,
			'ID' => 62,
			'TILDE' => 55,
			'RAW_CODE' => 60
		},
		GOTOS => {
			'function' => 61,
			'dtor' => 58,
			'perc_name' => 63,
			'methods' => 64,
			'method' => 57,
			'ctor' => 56,
			'class_name' => 36,
			'type' => 59
		}
	},
	{#State 44
		ACTIONS => {
			'CLCURLY' => 65
		}
	},
	{#State 45
		DEFAULT => -45
	},
	{#State 46
		ACTIONS => {
			'SLASH' => 67,
			'DOT' => 66
		}
	},
	{#State 47
		ACTIONS => {
			'AMP' => 69,
			'STAR' => 68
		}
	},
	{#State 48
		ACTIONS => {
			'OPCURLY' => 70
		}
	},
	{#State 49
		ACTIONS => {
			'ID' => 71
		}
	},
	{#State 50
		DEFAULT => -40
	},
	{#State 51
		DEFAULT => -41
	},
	{#State 52
		DEFAULT => -34
	},
	{#State 53
		DEFAULT => -35
	},
	{#State 54
		ACTIONS => {
			'p_name' => 2,
			"const" => 33,
			'ID' => 62,
			'TILDE' => 55,
			'RAW_CODE' => 60
		},
		GOTOS => {
			'function' => 61,
			'dtor' => 58,
			'perc_name' => 63,
			'methods' => 72,
			'method' => 57,
			'ctor' => 56,
			'class_name' => 36,
			'type' => 59
		}
	},
	{#State 55
		ACTIONS => {
			'ID' => 73
		}
	},
	{#State 56
		DEFAULT => -22
	},
	{#State 57
		DEFAULT => -16
	},
	{#State 58
		DEFAULT => -24
	},
	{#State 59
		ACTIONS => {
			'ID' => 74
		}
	},
	{#State 60
		DEFAULT => -18
	},
	{#State 61
		DEFAULT => -20
	},
	{#State 62
		ACTIONS => {
			'DCOLON' => 49,
			'OPPAR' => 75
		},
		DEFAULT => -43
	},
	{#State 63
		ACTIONS => {
			"const" => 33,
			'ID' => 62
		},
		GOTOS => {
			'function' => 77,
			'ctor' => 76,
			'class_name' => 36,
			'type' => 59
		}
	},
	{#State 64
		ACTIONS => {
			'p_name' => 2,
			"const" => 33,
			'ID' => 62,
			'TILDE' => 55,
			'RAW_CODE' => 79,
			'CLCURLY' => 80
		},
		GOTOS => {
			'function' => 61,
			'dtor' => 58,
			'perc_name' => 63,
			'method' => 78,
			'ctor' => 56,
			'class_name' => 36,
			'type' => 59
		}
	},
	{#State 65
		DEFAULT => -36
	},
	{#State 66
		ACTIONS => {
			'ID' => 81
		}
	},
	{#State 67
		ACTIONS => {
			'ID' => 46,
			'DASH' => 45
		},
		GOTOS => {
			'file_name' => 82
		}
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		DEFAULT => -39
	},
	{#State 70
		ACTIONS => {
			'ID' => 83
		}
	},
	{#State 71
		DEFAULT => -44
	},
	{#State 72
		ACTIONS => {
			'p_name' => 2,
			"const" => 33,
			'ID' => 62,
			'TILDE' => 55,
			'RAW_CODE' => 79,
			'CLCURLY' => 84
		},
		GOTOS => {
			'function' => 61,
			'dtor' => 58,
			'perc_name' => 63,
			'method' => 78,
			'ctor' => 56,
			'class_name' => 36,
			'type' => 59
		}
	},
	{#State 73
		ACTIONS => {
			'OPPAR' => 85
		}
	},
	{#State 74
		ACTIONS => {
			'OPPAR' => 86
		}
	},
	{#State 75
		ACTIONS => {
			"const" => 33,
			'ID' => 35,
			'CLPAR' => 90
		},
		GOTOS => {
			'arg_list' => 88,
			'class_name' => 36,
			'type' => 89,
			'argument' => 87
		}
	},
	{#State 76
		DEFAULT => -23
	},
	{#State 77
		DEFAULT => -21
	},
	{#State 78
		DEFAULT => -17
	},
	{#State 79
		DEFAULT => -19
	},
	{#State 80
		ACTIONS => {
			'SEMICOLON' => 91
		}
	},
	{#State 81
		DEFAULT => -46
	},
	{#State 82
		DEFAULT => -47
	},
	{#State 83
		ACTIONS => {
			'CLCURLY' => 92
		}
	},
	{#State 84
		ACTIONS => {
			'SEMICOLON' => 93
		}
	},
	{#State 85
		ACTIONS => {
			'CLPAR' => 94
		}
	},
	{#State 86
		ACTIONS => {
			"const" => 33,
			'ID' => 35,
			'CLPAR' => 96
		},
		GOTOS => {
			'arg_list' => 95,
			'class_name' => 36,
			'type' => 89,
			'argument' => 87
		}
	},
	{#State 87
		DEFAULT => -48
	},
	{#State 88
		ACTIONS => {
			'COMMA' => 98,
			'CLPAR' => 97
		}
	},
	{#State 89
		ACTIONS => {
			'ID' => 99
		}
	},
	{#State 90
		ACTIONS => {
			'p_code' => 101
		},
		DEFAULT => -33,
		GOTOS => {
			'metadata' => 102,
			'perc_code' => 100
		}
	},
	{#State 91
		DEFAULT => -15
	},
	{#State 92
		ACTIONS => {
			'OPSPECIAL' => 4
		},
		DEFAULT => -10,
		GOTOS => {
			'special_block' => 103,
			'special_block_start' => 5
		}
	},
	{#State 93
		DEFAULT => -14
	},
	{#State 94
		ACTIONS => {
			'SEMICOLON' => 104
		}
	},
	{#State 95
		ACTIONS => {
			'COMMA' => 98,
			'CLPAR' => 105
		}
	},
	{#State 96
		ACTIONS => {
			'p_code' => 101
		},
		DEFAULT => -33,
		GOTOS => {
			'metadata' => 106,
			'perc_code' => 100
		}
	},
	{#State 97
		ACTIONS => {
			'p_code' => 101
		},
		DEFAULT => -33,
		GOTOS => {
			'metadata' => 107,
			'perc_code' => 100
		}
	},
	{#State 98
		ACTIONS => {
			"const" => 33,
			'ID' => 35
		},
		GOTOS => {
			'class_name' => 36,
			'type' => 89,
			'argument' => 108
		}
	},
	{#State 99
		ACTIONS => {
			'EQUAL' => 109
		},
		DEFAULT => -50
	},
	{#State 100
		DEFAULT => -32
	},
	{#State 101
		ACTIONS => {
			'OPSPECIAL' => 4
		},
		GOTOS => {
			'special_block' => 110,
			'special_block_start' => 5
		}
	},
	{#State 102
		ACTIONS => {
			'SEMICOLON' => 111
		}
	},
	{#State 103
		DEFAULT => -11
	},
	{#State 104
		DEFAULT => -31
	},
	{#State 105
		ACTIONS => {
			'p_code' => 101
		},
		DEFAULT => -33,
		GOTOS => {
			'metadata' => 112,
			'perc_code' => 100
		}
	},
	{#State 106
		ACTIONS => {
			"const" => 114
		},
		DEFAULT => -26,
		GOTOS => {
			'const' => 113
		}
	},
	{#State 107
		ACTIONS => {
			'SEMICOLON' => 115
		}
	},
	{#State 108
		DEFAULT => -49
	},
	{#State 109
		ACTIONS => {
			'QUOTED_STRING' => 116,
			'ID' => 120,
			'DASH' => 117,
			'INTEGER' => 118
		},
		GOTOS => {
			'value' => 119
		}
	},
	{#State 110
		DEFAULT => -37
	},
	{#State 111
		DEFAULT => -30
	},
	{#State 112
		ACTIONS => {
			"const" => 114
		},
		DEFAULT => -26,
		GOTOS => {
			'const' => 121
		}
	},
	{#State 113
		ACTIONS => {
			'SEMICOLON' => 122
		}
	},
	{#State 114
		DEFAULT => -25
	},
	{#State 115
		DEFAULT => -29
	},
	{#State 116
		DEFAULT => -54
	},
	{#State 117
		ACTIONS => {
			'INTEGER' => 123
		}
	},
	{#State 118
		DEFAULT => -52
	},
	{#State 119
		DEFAULT => -51
	},
	{#State 120
		ACTIONS => {
			'DCOLON' => 124,
			'OPPAR' => 125
		},
		DEFAULT => -55
	},
	{#State 121
		ACTIONS => {
			'SEMICOLON' => 126
		}
	},
	{#State 122
		DEFAULT => -28
	},
	{#State 123
		DEFAULT => -53
	},
	{#State 124
		ACTIONS => {
			'ID' => 127
		}
	},
	{#State 125
		ACTIONS => {
			'QUOTED_STRING' => 116,
			'ID' => 120,
			'DASH' => 117,
			'INTEGER' => 118
		},
		GOTOS => {
			'value' => 128
		}
	},
	{#State 126
		DEFAULT => -27
	},
	{#State 127
		DEFAULT => -56
	},
	{#State 128
		ACTIONS => {
			'CLPAR' => 129
		}
	},
	{#State 129
		DEFAULT => -57
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'top', 1,
sub
#line 19 "script/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 2
		 'top', 1,
sub
#line 20 "script/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 3
		 'top', 1,
sub
#line 21 "script/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 4
		 'top', 2,
sub
#line 22 "script/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 5
		 'top', 2,
sub
#line 23 "script/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 6
		 'top', 2,
sub
#line 24 "script/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 7
		 'directive', 2,
sub
#line 28 "script/XSP.yp"
{ XSP::Parser::Module->new( module => $_[1] ) }
	],
	[#Rule 8
		 'directive', 2,
sub
#line 30 "script/XSP.yp"
{ XSP::Parser::File->new( file => $_[1] ) }
	],
	[#Rule 9
		 'directive', 2,
sub
#line 31 "script/XSP.yp"
{ add_data_raw( $_[0], [ "\n" ] ) }
	],
	[#Rule 10
		 'typemap', 7,
sub
#line 34 "script/XSP.yp"
{ my $package = "XSP::typemap::" . $_[6];
                      my $type = $_[3];
                      my $tm = $package->new( type => $type );
                      XSP::typemap::add_typemap_for_type( $type, $tm );
                      undef }
	],
	[#Rule 11
		 'typemap', 8,
sub
#line 41 "script/XSP.yp"
{ my $package = "XSP::typemap::" . $_[6];
                      my( $type, $arg1 ) = ( $_[3], join( '', @{$_[8]} ) );
                      my $tm = $package->new( type => $type,
                                              arg1 => $arg1 );
                      XSP::typemap::add_typemap_for_type( $type, $tm );
                      undef }
	],
	[#Rule 12
		 'raw', 1,
sub
#line 48 "script/XSP.yp"
{ add_data_raw( $_[0], [ $_[1] ] ) }
	],
	[#Rule 13
		 'raw', 1,
sub
#line 49 "script/XSP.yp"
{ add_data_raw( $_[0], $_[1] ) }
	],
	[#Rule 14
		 'class', 7,
sub
#line 52 "script/XSP.yp"
{ add_data_class( $_[0], class   => $_[3],
                                     perl    => $_[1],
                                     methods => $_[5] ) }
	],
	[#Rule 15
		 'class', 6,
sub
#line 56 "script/XSP.yp"
{ add_data_class( $_[0], class   => $_[2],
                                     methods => $_[4] ) }
	],
	[#Rule 16
		 'methods', 1,
sub
#line 59 "script/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 17
		 'methods', 2,
sub
#line 60 "script/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 18
		 'methods', 1,
sub
#line 61 "script/XSP.yp"
{ [ add_data_raw( $_[0], [ $_[1] ] ) ] }
	],
	[#Rule 19
		 'methods', 2,
sub
#line 63 "script/XSP.yp"
{ push @{$_[1]}, add_data_raw( $_[0], [ $_[2] ] ); $_[1] }
	],
	[#Rule 20
		 'method', 1,
sub
#line 65 "script/XSP.yp"
{ my $f = $_[1];
                           my $m = add_data_method
                             ( $_[0],
                               name      => $f->cpp_name,
                               ret_type  => $f->ret_type,
                               arguments => $f->arguments,
                               code      => $f->code );
                           $m
                         }
	],
	[#Rule 21
		 'method', 2,
sub
#line 75 "script/XSP.yp"
{ my $f = $_[2];
                      my $m = add_data_method
                        ( $_[0],
                          name      => $f->cpp_name,
                          ret_type  => $f->ret_type,
                          arguments => $f->arguments,
                          code      => $f->code );
                      $m->{PERL_NAME} = $_[1];
                      $m
                    }
	],
	[#Rule 22
		 'method', 1, undef
	],
	[#Rule 23
		 'method', 2,
sub
#line 87 "script/XSP.yp"
{ $_[2]->{PERL_NAME} = $_[1]; $_[2] }
	],
	[#Rule 24
		 'method', 1, undef
	],
	[#Rule 25
		 'const', 1, undef
	],
	[#Rule 26
		 'const', 0, undef
	],
	[#Rule 27
		 'function', 8,
sub
#line 94 "script/XSP.yp"
{ add_data_function( $_[0],
                                         name      => $_[2],
                                         ret_type  => $_[1],
                                         arguments => $_[4],
                                         @{ $_[6] } ) }
	],
	[#Rule 28
		 'function', 7,
sub
#line 100 "script/XSP.yp"
{ add_data_function( $_[0],
                                         name     => $_[2],
                                         ret_type => $_[1],
                                         @{ $_[5] } ) }
	],
	[#Rule 29
		 'ctor', 6,
sub
#line 106 "script/XSP.yp"
{ add_data_ctor( $_[0], name      => $_[1],
                                            arguments => $_[3],
                                            @{ $_[5] } ) }
	],
	[#Rule 30
		 'ctor', 5,
sub
#line 110 "script/XSP.yp"
{ add_data_ctor( $_[0], name => $_[1],
                                            @{ $_[4] } ) }
	],
	[#Rule 31
		 'dtor', 5,
sub
#line 114 "script/XSP.yp"
{ add_data_dtor( $_[0], $_[2] ) }
	],
	[#Rule 32
		 'metadata', 1,
sub
#line 116 "script/XSP.yp"
{ $_[1] }
	],
	[#Rule 33
		 'metadata', 0,
sub
#line 117 "script/XSP.yp"
{ [] }
	],
	[#Rule 34
		 'perc_name', 4,
sub
#line 119 "script/XSP.yp"
{ $_[3] }
	],
	[#Rule 35
		 'perc_module', 4,
sub
#line 120 "script/XSP.yp"
{ $_[3] }
	],
	[#Rule 36
		 'perc_file', 4,
sub
#line 121 "script/XSP.yp"
{ $_[3] }
	],
	[#Rule 37
		 'perc_code', 2,
sub
#line 122 "script/XSP.yp"
{ [ code => $_[2] ] }
	],
	[#Rule 38
		 'type', 3,
sub
#line 124 "script/XSP.yp"
{ make_cptr( $_[0], $_[2] ) }
	],
	[#Rule 39
		 'type', 3,
sub
#line 125 "script/XSP.yp"
{ make_cref( $_[0], $_[2] ) }
	],
	[#Rule 40
		 'type', 2,
sub
#line 126 "script/XSP.yp"
{ make_ptr( $_[0], $_[1] ) }
	],
	[#Rule 41
		 'type', 2,
sub
#line 127 "script/XSP.yp"
{ make_ref( $_[0], $_[1] ) }
	],
	[#Rule 42
		 'type', 1,
sub
#line 128 "script/XSP.yp"
{ make_type( $_[0], $_[1] ) }
	],
	[#Rule 43
		 'class_name', 1, undef
	],
	[#Rule 44
		 'class_name', 3,
sub
#line 131 "script/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 45
		 'file_name', 1,
sub
#line 133 "script/XSP.yp"
{ '-' }
	],
	[#Rule 46
		 'file_name', 3,
sub
#line 134 "script/XSP.yp"
{ $_[1] . '.' . $_[3] }
	],
	[#Rule 47
		 'file_name', 3,
sub
#line 135 "script/XSP.yp"
{ $_[1] . '/' . $_[3] }
	],
	[#Rule 48
		 'arg_list', 1,
sub
#line 137 "script/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 49
		 'arg_list', 3,
sub
#line 138 "script/XSP.yp"
{ push @{$_[1]}, $_[3]; $_[1] }
	],
	[#Rule 50
		 'argument', 2,
sub
#line 140 "script/XSP.yp"
{ make_argument( @_ ) }
	],
	[#Rule 51
		 'argument', 4,
sub
#line 142 "script/XSP.yp"
{ make_argument( @_[0, 1, 2, 4] ) }
	],
	[#Rule 52
		 'value', 1, undef
	],
	[#Rule 53
		 'value', 2,
sub
#line 145 "script/XSP.yp"
{ '-' . $_[2] }
	],
	[#Rule 54
		 'value', 1, undef
	],
	[#Rule 55
		 'value', 1, undef
	],
	[#Rule 56
		 'value', 3,
sub
#line 148 "script/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 57
		 'value', 4,
sub
#line 149 "script/XSP.yp"
{ "$_[1]($_[3])" }
	],
	[#Rule 58
		 'special_block', 3,
sub
#line 154 "script/XSP.yp"
{ $_[2] }
	],
	[#Rule 59
		 'special_block_start', 1,
sub
#line 156 "script/XSP.yp"
{ push_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 60
		 'special_block_end', 1,
sub
#line 158 "script/XSP.yp"
{ pop_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 61
		 'lines', 1,
sub
#line 160 "script/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 62
		 'lines', 2,
sub
#line 161 "script/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	]
],
                                  @_);
    bless($self,$class);
}

#line 163 "script/XSP.yp"


my %tokens = ( '::' => 'DCOLON',
               '%{' => 'OPSPECIAL',
               '%}' => 'CLSPECIAL',
               '{%' => 'OPSPECIAL',
                '{' => 'OPCURLY',
                '}' => 'CLCURLY',
                '(' => 'OPPAR',
                ')' => 'CLPAR',
                ';' => 'SEMICOLON',
                '%' => 'PERC',
                '~' => 'TILDE',
                '*' => 'STAR',
                '&' => 'AMP',
                ',' => 'COMMA',
                '=' => 'EQUAL',
                '/' => 'SLASH',
                '.' => 'DOT',
                '-' => 'DASH',
               # these are here due to my lack of skill with yacc
               '%name' => 'p_name',
               '%typemap' => 'p_typemap',
               '%file' => 'p_file',
               '%module' => 'p_module',
               '%code' => 'p_code',
             );

my %keywords = ( const => 1,
                 class => 1,
               );

sub get_lex_mode { return $_[0]->YYData->{LEX}{MODES}[0] || '' }

sub push_lex_mode {
  my( $p, $mode ) = @_;

  push @{$p->YYData->{LEX}{MODES}}, $mode;
}

sub pop_lex_mode {
  my( $p, $mode ) = @_;

  die "Unexpected mode: '$mode'"
    unless get_lex_mode( $p ) eq $mode;

  pop @{$p->YYData->{LEX}{MODES}};
}

sub read_more {
  my( $fh, $buf ) = @_;
  my $v = <$fh>;

  return unless defined $v;

  $$buf .= $v;

  return 1;
}

sub yylex {
  my $data = $_[0]->YYData->{LEX};
  my $fh = $data->{FH};
  my $buf = $data->{BUFFER};

  for(;;) {
    if( !length( $$buf ) && !read_more( $fh, $buf ) ) {
      return ( '', undef );
    }

    if( get_lex_mode( $_[0] ) eq 'special' ) {
      if( $$buf =~ s/^%}// ) {
        return ( 'CLSPECIAL', '%}' );
      } elsif( $$buf =~ s/^([^\n]*)\n$// ) {
        my $line = $1;

        if( $line =~ m/^(.*?)\%}(.*)$/ ) {
          $$buf = "%}$2\n";
          $line = $1;
        }

        return ( 'line', $line );
      }
    } else {
      $$buf =~ s/^[\s\n\r]+//;
      next unless length $$buf;

      if( $$buf =~ s/^( \%}
                      | \%{ | {\%
                      | \%name | \%typemap | \%module | \%typemap | \%code
                      | \%file
                      | [{}();%~*&,=\/\.\-]
                      | ::
                       )//x ) {
        return ( $tokens{$1}, $1 );
      } elsif( $$buf =~ m/^([a-zA-Z_]\w*)\W/ ) {
        $$buf =~ s/^(\w+)//;

        return ( $1, $1 ) if exists $keywords{$1};

        return ( 'ID', $1 );
      } elsif( $$buf =~ s/^(\d+)// ) {
        return ( 'INTEGER', $1 );
      } elsif( $$buf =~ s/^("[^"]*")// ) {
        return ( 'QUOTED_STRING', $1 );
      } elsif( $$buf =~ s/^(#.*(?:\r\n|\r|\n))// ) {
        return ( 'RAW_CODE', $1 );
      } else {
        warn $$buf;
      }
    }
  }
}

sub yyerror {
  my $buf = $_[0]->YYData->{LEX}{BUFFER};

  print "Error: (", $_[0]->YYCurtok, ') (',
    $_[0]->YYCurval, ') "', ( $buf ? $$buf : '--empty buffer--' ),
      q{"} . "\n";
  print "Expecting: (", ( join ", ", map { "'$_'" } $_[0]->YYExpect ),
        ")\n";
}

sub make_cptr { XSP::Parser::Type->new( base => $_[1],
                                        const => 1, pointer => 1 ) }
sub make_cref { XSP::Parser::Type->new( base => $_[1],
                                        const => 1, reference => 1 ) }
sub make_ref  { XSP::Parser::Type->new( base => $_[1], reference => 1 ) }
sub make_ptr  { XSP::Parser::Type->new( base => $_[1], pointer => 1 ) }
sub make_type { XSP::Parser::Type->new( base => $_[1] ) }

sub add_data_raw {
  my $p = shift;
  my $rows = shift;

  XSP::Parser::Raw->new( rows => $rows );
}

sub make_argument {
  my( $p, $type, $name, $default ) = @_;

  XSP::Parser::Argument->new( type    => $type,
                              name    => $name,
                              default => $default );
}

sub add_data_class {
  my( $parser, %args ) = @_;

  my $class = XSP::Parser::Class->new( perl_name => $args{perl},
                                       cpp_name => $args{class},
                                       methods => $args{methods} );

  foreach my $m ( @{$class->methods} ) { $m->{CLASS} = $class }

  $class;
}

sub add_data_function {
  my( $parser, %args ) = @_;

  XSP::Parser::Function->new( cpp_name  => $args{name},
                              ret_type  => $args{ret_type},
                              arguments => $args{arguments},
                              code      => $args{code} );
}

sub add_data_method {
  my( $parser, %args ) = @_;

  XSP::Parser::Method->new( cpp_name  => $args{name},
                            ret_type  => $args{ret_type},
                            arguments => $args{arguments},
                            code      => $args{code} );
}

sub add_data_ctor {
  my( $parser, %args ) = @_;

  XSP::Parser::Constructor->new( cpp_name  => $args{name},
                                 arguments => $args{arguments},
                                 code      => $args{code} );
}

sub add_data_dtor {
  my( $parser, $name ) = @_;

  XSP::Parser::Destructor->new( cpp_name => $name ); 
}

sub is_directive {
  my( $p, $d, $name ) = @_;

  return $d->[0] eq $name;
}

#sub assert_directive {
#  my( $p, $d, $name ) = @_;
#
#  if( $d->[0] ne $name )
#    { $p->YYError }
#  1;
#}

1;
