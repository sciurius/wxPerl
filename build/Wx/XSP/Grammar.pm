####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package Wx::XSP::Grammar;
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
			'ID' => 1,
			'p_module' => 18,
			'p_typemap' => 3,
			'OPSPECIAL' => 5,
			"short" => 20,
			"class" => 8,
			'p_file' => 21,
			'RAW_CODE' => 9,
			'p_name' => 24,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'perc_file' => 17,
			'basic_type' => 16,
			'function' => 4,
			'_func' => 19,
			'special_block_start' => 6,
			'perc_name' => 7,
			'top' => 22,
			'typemap' => 10,
			'type' => 28,
			'class' => 27,
			'directive' => 26,
			'special_block' => 12,
			'perc_module' => 14,
			'raw' => 30
		}
	},
	{#State 1
		ACTIONS => {
			'DCOLON' => 31
		},
		DEFAULT => -58
	},
	{#State 2
		DEFAULT => -48
	},
	{#State 3
		ACTIONS => {
			'OPCURLY' => 32
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		DEFAULT => -75
	},
	{#State 6
		ACTIONS => {
			'line' => 34
		},
		GOTOS => {
			'lines' => 33
		}
	},
	{#State 7
		ACTIONS => {
			'ID' => 1,
			"short" => 20,
			"class" => 35,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'basic_type' => 16,
			'_func' => 36,
			'type' => 28
		}
	},
	{#State 8
		ACTIONS => {
			'ID' => 37
		}
	},
	{#State 9
		DEFAULT => -14
	},
	{#State 10
		ACTIONS => {
			'SEMICOLON' => 38
		}
	},
	{#State 11
		ACTIONS => {
			'ID' => 1,
			"short" => 20,
			"unsigned" => 23,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 39,
			'class_name' => 2,
			'basic_type' => 16
		}
	},
	{#State 12
		DEFAULT => -15
	},
	{#State 13
		DEFAULT => -53
	},
	{#State 14
		ACTIONS => {
			'SEMICOLON' => 40
		}
	},
	{#State 15
		ACTIONS => {
			'STAR' => 42,
			'AMP' => 41
		},
		DEFAULT => -47
	},
	{#State 16
		DEFAULT => -49
	},
	{#State 17
		ACTIONS => {
			'SEMICOLON' => 43
		}
	},
	{#State 18
		ACTIONS => {
			'OPCURLY' => 44
		}
	},
	{#State 19
		DEFAULT => -30
	},
	{#State 20
		ACTIONS => {
			"int" => 45
		},
		DEFAULT => -52
	},
	{#State 21
		ACTIONS => {
			'OPCURLY' => 46
		}
	},
	{#State 22
		ACTIONS => {
			'' => 47,
			'ID' => 1,
			'p_module' => 18,
			'p_typemap' => 3,
			'OPSPECIAL' => 5,
			"short" => 20,
			"class" => 8,
			'p_file' => 21,
			'RAW_CODE' => 9,
			'p_name' => 24,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'perc_file' => 17,
			'basic_type' => 16,
			'function' => 48,
			'_func' => 19,
			'special_block_start' => 6,
			'perc_name' => 7,
			'typemap' => 10,
			'class' => 50,
			'directive' => 49,
			'type' => 28,
			'special_block' => 12,
			'perc_module' => 14,
			'raw' => 51
		}
	},
	{#State 23
		ACTIONS => {
			"short" => 20,
			"unsigned" => 53,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		DEFAULT => -55,
		GOTOS => {
			'basic_type' => 52
		}
	},
	{#State 24
		ACTIONS => {
			'OPCURLY' => 54
		}
	},
	{#State 25
		ACTIONS => {
			"int" => 55
		},
		DEFAULT => -54
	},
	{#State 26
		DEFAULT => -3
	},
	{#State 27
		DEFAULT => -2
	},
	{#State 28
		ACTIONS => {
			'ID' => 56
		}
	},
	{#State 29
		DEFAULT => -51
	},
	{#State 30
		DEFAULT => -1
	},
	{#State 31
		ACTIONS => {
			'ID' => 57
		}
	},
	{#State 32
		ACTIONS => {
			'ID' => 1,
			"short" => 20,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 58
		}
	},
	{#State 33
		ACTIONS => {
			'CLSPECIAL' => 59,
			'line' => 60
		},
		GOTOS => {
			'special_block_end' => 61
		}
	},
	{#State 34
		DEFAULT => -77
	},
	{#State 35
		ACTIONS => {
			'ID' => 62
		}
	},
	{#State 36
		DEFAULT => -31
	},
	{#State 37
		ACTIONS => {
			'OPCURLY' => 63
		}
	},
	{#State 38
		DEFAULT => -11
	},
	{#State 39
		ACTIONS => {
			'STAR' => 65,
			'AMP' => 64
		}
	},
	{#State 40
		DEFAULT => -9
	},
	{#State 41
		DEFAULT => -46
	},
	{#State 42
		DEFAULT => -45
	},
	{#State 43
		DEFAULT => -10
	},
	{#State 44
		ACTIONS => {
			'ID' => 1
		},
		GOTOS => {
			'class_name' => 66
		}
	},
	{#State 45
		DEFAULT => -57
	},
	{#State 46
		ACTIONS => {
			'ID' => 67,
			'DASH' => 69
		},
		GOTOS => {
			'file_name' => 68
		}
	},
	{#State 47
		DEFAULT => 0
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		DEFAULT => -7
	},
	{#State 50
		DEFAULT => -6
	},
	{#State 51
		DEFAULT => -5
	},
	{#State 52
		DEFAULT => -50
	},
	{#State 53
		DEFAULT => -55
	},
	{#State 54
		ACTIONS => {
			'ID' => 1
		},
		GOTOS => {
			'class_name' => 70
		}
	},
	{#State 55
		DEFAULT => -56
	},
	{#State 56
		ACTIONS => {
			'OPPAR' => 71
		}
	},
	{#State 57
		DEFAULT => -59
	},
	{#State 58
		ACTIONS => {
			'CLCURLY' => 72
		}
	},
	{#State 59
		DEFAULT => -76
	},
	{#State 60
		DEFAULT => -78
	},
	{#State 61
		DEFAULT => -74
	},
	{#State 62
		ACTIONS => {
			'OPCURLY' => 73
		}
	},
	{#State 63
		ACTIONS => {
			'ID' => 74,
			'CLCURLY' => 81,
			"short" => 20,
			'RAW_CODE' => 77,
			'TILDE' => 82,
			"const" => 11,
			"unsigned" => 23,
			'p_name' => 24,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 80,
			'basic_type' => 16,
			'function' => 75,
			'_func' => 19,
			'perc_name' => 76,
			'methods' => 78,
			'dtor' => 83,
			'type' => 28,
			'method' => 79
		}
	},
	{#State 64
		DEFAULT => -44
	},
	{#State 65
		DEFAULT => -43
	},
	{#State 66
		ACTIONS => {
			'CLCURLY' => 84
		}
	},
	{#State 67
		ACTIONS => {
			'DOT' => 86,
			'SLASH' => 85
		}
	},
	{#State 68
		ACTIONS => {
			'CLCURLY' => 87
		}
	},
	{#State 69
		DEFAULT => -60
	},
	{#State 70
		ACTIONS => {
			'CLCURLY' => 88
		}
	},
	{#State 71
		ACTIONS => {
			'ID' => 1,
			'CLPAR' => 91,
			"short" => 20,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'argument' => 90,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 92,
			'arg_list' => 89
		}
	},
	{#State 72
		ACTIONS => {
			'OPCURLY' => 93
		}
	},
	{#State 73
		ACTIONS => {
			'ID' => 74,
			'CLCURLY' => 95,
			"short" => 20,
			'RAW_CODE' => 77,
			'TILDE' => 82,
			"const" => 11,
			"unsigned" => 23,
			'p_name' => 24,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 80,
			'basic_type' => 16,
			'function' => 75,
			'_func' => 19,
			'perc_name' => 76,
			'methods' => 94,
			'dtor' => 83,
			'type' => 28,
			'method' => 79
		}
	},
	{#State 74
		ACTIONS => {
			'DCOLON' => 31,
			'OPPAR' => 96
		},
		DEFAULT => -58
	},
	{#State 75
		DEFAULT => -24
	},
	{#State 76
		ACTIONS => {
			'ID' => 74,
			"short" => 20,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 97,
			'basic_type' => 16,
			'_func' => 36,
			'type' => 28
		}
	},
	{#State 77
		DEFAULT => -22
	},
	{#State 78
		ACTIONS => {
			'ID' => 74,
			'CLCURLY' => 100,
			"short" => 20,
			'RAW_CODE' => 98,
			'TILDE' => 82,
			"const" => 11,
			"unsigned" => 23,
			'p_name' => 24,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 80,
			'basic_type' => 16,
			'function' => 75,
			'_func' => 19,
			'perc_name' => 76,
			'dtor' => 83,
			'method' => 99,
			'type' => 28
		}
	},
	{#State 79
		DEFAULT => -20
	},
	{#State 80
		DEFAULT => -25
	},
	{#State 81
		ACTIONS => {
			'SEMICOLON' => 101
		}
	},
	{#State 82
		ACTIONS => {
			'ID' => 102
		}
	},
	{#State 83
		DEFAULT => -27
	},
	{#State 84
		DEFAULT => -40
	},
	{#State 85
		ACTIONS => {
			'ID' => 67,
			'DASH' => 69
		},
		GOTOS => {
			'file_name' => 103
		}
	},
	{#State 86
		ACTIONS => {
			'ID' => 104
		}
	},
	{#State 87
		DEFAULT => -41
	},
	{#State 88
		DEFAULT => -39
	},
	{#State 89
		ACTIONS => {
			'CLPAR' => 106,
			'COMMA' => 105
		}
	},
	{#State 90
		DEFAULT => -63
	},
	{#State 91
		ACTIONS => {
			'p_code' => 108
		},
		DEFAULT => -38,
		GOTOS => {
			'perc_code' => 107,
			'metadata' => 109
		}
	},
	{#State 92
		ACTIONS => {
			'ID' => 110
		}
	},
	{#State 93
		ACTIONS => {
			'ID' => 111
		}
	},
	{#State 94
		ACTIONS => {
			'ID' => 74,
			'CLCURLY' => 112,
			"short" => 20,
			'RAW_CODE' => 98,
			'TILDE' => 82,
			"const" => 11,
			"unsigned" => 23,
			'p_name' => 24,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 80,
			'basic_type' => 16,
			'function' => 75,
			'_func' => 19,
			'perc_name' => 76,
			'dtor' => 83,
			'method' => 99,
			'type' => 28
		}
	},
	{#State 95
		ACTIONS => {
			'SEMICOLON' => 113
		}
	},
	{#State 96
		ACTIONS => {
			'ID' => 1,
			'CLPAR' => 115,
			"short" => 20,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'argument' => 90,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 92,
			'arg_list' => 114
		}
	},
	{#State 97
		DEFAULT => -26
	},
	{#State 98
		DEFAULT => -23
	},
	{#State 99
		DEFAULT => -21
	},
	{#State 100
		ACTIONS => {
			'SEMICOLON' => 116
		}
	},
	{#State 101
		DEFAULT => -19
	},
	{#State 102
		ACTIONS => {
			'OPPAR' => 117
		}
	},
	{#State 103
		DEFAULT => -62
	},
	{#State 104
		DEFAULT => -61
	},
	{#State 105
		ACTIONS => {
			'ID' => 1,
			"short" => 20,
			"unsigned" => 23,
			"const" => 11,
			"long" => 25,
			"int" => 13,
			"char" => 29
		},
		GOTOS => {
			'type_name' => 15,
			'argument' => 118,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 92
		}
	},
	{#State 106
		ACTIONS => {
			'p_code' => 108
		},
		DEFAULT => -38,
		GOTOS => {
			'perc_code' => 107,
			'metadata' => 119
		}
	},
	{#State 107
		DEFAULT => -37
	},
	{#State 108
		ACTIONS => {
			'OPSPECIAL' => 5
		},
		GOTOS => {
			'special_block' => 120,
			'special_block_start' => 6
		}
	},
	{#State 109
		ACTIONS => {
			"const" => 121
		},
		DEFAULT => -29,
		GOTOS => {
			'const' => 122
		}
	},
	{#State 110
		ACTIONS => {
			'EQUAL' => 123
		},
		DEFAULT => -65
	},
	{#State 111
		ACTIONS => {
			'CLCURLY' => 124
		}
	},
	{#State 112
		ACTIONS => {
			'SEMICOLON' => 125
		}
	},
	{#State 113
		DEFAULT => -18
	},
	{#State 114
		ACTIONS => {
			'CLPAR' => 126,
			'COMMA' => 105
		}
	},
	{#State 115
		ACTIONS => {
			'p_code' => 108
		},
		DEFAULT => -38,
		GOTOS => {
			'perc_code' => 107,
			'metadata' => 127
		}
	},
	{#State 116
		DEFAULT => -17
	},
	{#State 117
		ACTIONS => {
			'CLPAR' => 128
		}
	},
	{#State 118
		DEFAULT => -64
	},
	{#State 119
		ACTIONS => {
			"const" => 121
		},
		DEFAULT => -29,
		GOTOS => {
			'const' => 129
		}
	},
	{#State 120
		DEFAULT => -42
	},
	{#State 121
		DEFAULT => -28
	},
	{#State 122
		ACTIONS => {
			'SEMICOLON' => 130
		}
	},
	{#State 123
		ACTIONS => {
			'INTEGER' => 134,
			'ID' => 131,
			'QUOTED_STRING' => 136,
			'DASH' => 133,
			'FLOAT' => 132
		},
		GOTOS => {
			'value' => 135
		}
	},
	{#State 124
		ACTIONS => {
			'OPSPECIAL' => 5
		},
		DEFAULT => -12,
		GOTOS => {
			'special_block' => 137,
			'special_block_start' => 6
		}
	},
	{#State 125
		DEFAULT => -16
	},
	{#State 126
		ACTIONS => {
			'p_code' => 108
		},
		DEFAULT => -38,
		GOTOS => {
			'perc_code' => 107,
			'metadata' => 138
		}
	},
	{#State 127
		ACTIONS => {
			'SEMICOLON' => 139
		}
	},
	{#State 128
		ACTIONS => {
			'SEMICOLON' => 140
		}
	},
	{#State 129
		ACTIONS => {
			'SEMICOLON' => 141
		}
	},
	{#State 130
		DEFAULT => -33
	},
	{#State 131
		ACTIONS => {
			'DCOLON' => 142,
			'OPPAR' => 143
		},
		DEFAULT => -71
	},
	{#State 132
		DEFAULT => -69
	},
	{#State 133
		ACTIONS => {
			'INTEGER' => 144
		}
	},
	{#State 134
		DEFAULT => -67
	},
	{#State 135
		DEFAULT => -66
	},
	{#State 136
		DEFAULT => -70
	},
	{#State 137
		DEFAULT => -13
	},
	{#State 138
		ACTIONS => {
			'SEMICOLON' => 145
		}
	},
	{#State 139
		DEFAULT => -35
	},
	{#State 140
		DEFAULT => -36
	},
	{#State 141
		DEFAULT => -32
	},
	{#State 142
		ACTIONS => {
			'ID' => 146
		}
	},
	{#State 143
		ACTIONS => {
			'INTEGER' => 134,
			'ID' => 131,
			'QUOTED_STRING' => 136,
			'DASH' => 133,
			'FLOAT' => 132
		},
		GOTOS => {
			'value' => 147
		}
	},
	{#State 144
		DEFAULT => -68
	},
	{#State 145
		DEFAULT => -34
	},
	{#State 146
		DEFAULT => -72
	},
	{#State 147
		ACTIONS => {
			'CLPAR' => 148
		}
	},
	{#State 148
		DEFAULT => -73
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
#line 19 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 2
		 'top', 1,
sub
#line 20 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 3
		 'top', 1,
sub
#line 21 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 4
		 'top', 1,
sub
#line 22 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 5
		 'top', 2,
sub
#line 23 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 6
		 'top', 2,
sub
#line 24 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 7
		 'top', 2,
sub
#line 25 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 8
		 'top', 2,
sub
#line 26 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 9
		 'directive', 2,
sub
#line 30 "build/Wx/XSP/XSP.yp"
{ Wx::XSP::Node::Module->new( module => $_[1] ) }
	],
	[#Rule 10
		 'directive', 2,
sub
#line 32 "build/Wx/XSP/XSP.yp"
{ Wx::XSP::Node::File->new( file => $_[1] ) }
	],
	[#Rule 11
		 'directive', 2,
sub
#line 33 "build/Wx/XSP/XSP.yp"
{ add_data_raw( $_[0], [ "\n" ] ) }
	],
	[#Rule 12
		 'typemap', 7,
sub
#line 36 "build/Wx/XSP/XSP.yp"
{ my $package = "Wx::XSP::Typemap::" . $_[6];
                      my $type = $_[3];
                      my $tm = $package->new( type => $type );
                      Wx::XSP::Typemap::add_typemap_for_type( $type, $tm );
                      undef }
	],
	[#Rule 13
		 'typemap', 8,
sub
#line 43 "build/Wx/XSP/XSP.yp"
{ my $package = "Wx::XSP::Typemap::" . $_[6];
                      my( $type, $arg1 ) = ( $_[3], join( '', @{$_[8]} ) );
                      my $tm = $package->new( type => $type,
                                              arg1 => $arg1 );
                      Wx::XSP::Typemap::add_typemap_for_type( $type, $tm );
                      undef }
	],
	[#Rule 14
		 'raw', 1,
sub
#line 50 "build/Wx/XSP/XSP.yp"
{ add_data_raw( $_[0], [ $_[1] ] ) }
	],
	[#Rule 15
		 'raw', 1,
sub
#line 51 "build/Wx/XSP/XSP.yp"
{ add_data_raw( $_[0], $_[1] ) }
	],
	[#Rule 16
		 'class', 7,
sub
#line 54 "build/Wx/XSP/XSP.yp"
{ add_data_class( $_[0], class   => $_[3],
                                     perl    => $_[1],
                                     methods => $_[5] ) }
	],
	[#Rule 17
		 'class', 6,
sub
#line 58 "build/Wx/XSP/XSP.yp"
{ add_data_class( $_[0], class   => $_[2],
                                     methods => $_[4] ) }
	],
	[#Rule 18
		 'class', 6,
sub
#line 61 "build/Wx/XSP/XSP.yp"
{ add_data_class( $_[0], class   => $_[3],
                                     perl    => $_[1] ) }
	],
	[#Rule 19
		 'class', 5,
sub
#line 64 "build/Wx/XSP/XSP.yp"
{ add_data_class( $_[0], class   => $_[2] ) }
	],
	[#Rule 20
		 'methods', 1,
sub
#line 66 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 21
		 'methods', 2,
sub
#line 67 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 22
		 'methods', 1,
sub
#line 68 "build/Wx/XSP/XSP.yp"
{ [ add_data_raw( $_[0], [ $_[1] ] ) ] }
	],
	[#Rule 23
		 'methods', 2,
sub
#line 70 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, add_data_raw( $_[0], [ $_[2] ] ); $_[1] }
	],
	[#Rule 24
		 'method', 1,
sub
#line 72 "build/Wx/XSP/XSP.yp"
{ my $f = $_[1];
                           my $m = add_data_method
                             ( $_[0],
                               name      => $f->cpp_name,
                               ret_type  => $f->ret_type,
                               arguments => $f->arguments,
                               code      => $f->code );
                           $m->{PERL_NAME} = $_[1]->{PERL_NAME};
                           $m
                         }
	],
	[#Rule 25
		 'method', 1, undef
	],
	[#Rule 26
		 'method', 2,
sub
#line 84 "build/Wx/XSP/XSP.yp"
{ $_[2]->{PERL_NAME} = $_[1]; $_[2] }
	],
	[#Rule 27
		 'method', 1, undef
	],
	[#Rule 28
		 'const', 1, undef
	],
	[#Rule 29
		 'const', 0, undef
	],
	[#Rule 30
		 'function', 1, undef
	],
	[#Rule 31
		 'function', 2,
sub
#line 92 "build/Wx/XSP/XSP.yp"
{ $_[2]->{PERL_NAME} = $_[1]; $_[2] }
	],
	[#Rule 32
		 '_func', 8,
sub
#line 96 "build/Wx/XSP/XSP.yp"
{ add_data_function( $_[0],
                                         name      => $_[2],
                                         ret_type  => $_[1],
                                         arguments => $_[4],
                                         @{ $_[6] } ) }
	],
	[#Rule 33
		 '_func', 7,
sub
#line 102 "build/Wx/XSP/XSP.yp"
{ add_data_function( $_[0],
                                         name     => $_[2],
                                         ret_type => $_[1],
                                         @{ $_[5] } ) }
	],
	[#Rule 34
		 'ctor', 6,
sub
#line 108 "build/Wx/XSP/XSP.yp"
{ add_data_ctor( $_[0], name      => $_[1],
                                            arguments => $_[3],
                                            @{ $_[5] } ) }
	],
	[#Rule 35
		 'ctor', 5,
sub
#line 112 "build/Wx/XSP/XSP.yp"
{ add_data_ctor( $_[0], name => $_[1],
                                            @{ $_[4] } ) }
	],
	[#Rule 36
		 'dtor', 5,
sub
#line 116 "build/Wx/XSP/XSP.yp"
{ add_data_dtor( $_[0], $_[2] ) }
	],
	[#Rule 37
		 'metadata', 1,
sub
#line 118 "build/Wx/XSP/XSP.yp"
{ $_[1] }
	],
	[#Rule 38
		 'metadata', 0,
sub
#line 119 "build/Wx/XSP/XSP.yp"
{ [] }
	],
	[#Rule 39
		 'perc_name', 4,
sub
#line 121 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 40
		 'perc_module', 4,
sub
#line 122 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 41
		 'perc_file', 4,
sub
#line 123 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 42
		 'perc_code', 2,
sub
#line 124 "build/Wx/XSP/XSP.yp"
{ [ code => $_[2] ] }
	],
	[#Rule 43
		 'type', 3,
sub
#line 126 "build/Wx/XSP/XSP.yp"
{ make_cptr( $_[0], $_[2] ) }
	],
	[#Rule 44
		 'type', 3,
sub
#line 127 "build/Wx/XSP/XSP.yp"
{ make_cref( $_[0], $_[2] ) }
	],
	[#Rule 45
		 'type', 2,
sub
#line 128 "build/Wx/XSP/XSP.yp"
{ make_ptr( $_[0], $_[1] ) }
	],
	[#Rule 46
		 'type', 2,
sub
#line 129 "build/Wx/XSP/XSP.yp"
{ make_ref( $_[0], $_[1] ) }
	],
	[#Rule 47
		 'type', 1,
sub
#line 130 "build/Wx/XSP/XSP.yp"
{ make_type( $_[0], $_[1] ) }
	],
	[#Rule 48
		 'type_name', 1, undef
	],
	[#Rule 49
		 'type_name', 1, undef
	],
	[#Rule 50
		 'type_name', 2, undef
	],
	[#Rule 51
		 'basic_type', 1, undef
	],
	[#Rule 52
		 'basic_type', 1, undef
	],
	[#Rule 53
		 'basic_type', 1, undef
	],
	[#Rule 54
		 'basic_type', 1, undef
	],
	[#Rule 55
		 'basic_type', 1, undef
	],
	[#Rule 56
		 'basic_type', 2, undef
	],
	[#Rule 57
		 'basic_type', 2, undef
	],
	[#Rule 58
		 'class_name', 1, undef
	],
	[#Rule 59
		 'class_name', 3,
sub
#line 138 "build/Wx/XSP/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 60
		 'file_name', 1,
sub
#line 140 "build/Wx/XSP/XSP.yp"
{ '-' }
	],
	[#Rule 61
		 'file_name', 3,
sub
#line 141 "build/Wx/XSP/XSP.yp"
{ $_[1] . '.' . $_[3] }
	],
	[#Rule 62
		 'file_name', 3,
sub
#line 142 "build/Wx/XSP/XSP.yp"
{ $_[1] . '/' . $_[3] }
	],
	[#Rule 63
		 'arg_list', 1,
sub
#line 144 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 64
		 'arg_list', 3,
sub
#line 145 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[3]; $_[1] }
	],
	[#Rule 65
		 'argument', 2,
sub
#line 147 "build/Wx/XSP/XSP.yp"
{ make_argument( @_ ) }
	],
	[#Rule 66
		 'argument', 4,
sub
#line 149 "build/Wx/XSP/XSP.yp"
{ make_argument( @_[0, 1, 2, 4] ) }
	],
	[#Rule 67
		 'value', 1, undef
	],
	[#Rule 68
		 'value', 2,
sub
#line 152 "build/Wx/XSP/XSP.yp"
{ '-' . $_[2] }
	],
	[#Rule 69
		 'value', 1, undef
	],
	[#Rule 70
		 'value', 1, undef
	],
	[#Rule 71
		 'value', 1, undef
	],
	[#Rule 72
		 'value', 3,
sub
#line 156 "build/Wx/XSP/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 73
		 'value', 4,
sub
#line 157 "build/Wx/XSP/XSP.yp"
{ "$_[1]($_[3])" }
	],
	[#Rule 74
		 'special_block', 3,
sub
#line 162 "build/Wx/XSP/XSP.yp"
{ $_[2] }
	],
	[#Rule 75
		 'special_block_start', 1,
sub
#line 164 "build/Wx/XSP/XSP.yp"
{ push_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 76
		 'special_block_end', 1,
sub
#line 166 "build/Wx/XSP/XSP.yp"
{ pop_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 77
		 'lines', 1,
sub
#line 168 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 78
		 'lines', 2,
sub
#line 169 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	]
],
                                  @_);
    bless($self,$class);
}

#line 171 "build/Wx/XSP/XSP.yp"


use Wx::XSP::Node;
use Wx::XSP::Typemap;

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
                 unsigned => 1,
                 short => 1,
                 long => 1,
                 int => 1,
                 char => 1,
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


      if( $$buf =~ s/^([+-]?(?=\d|\.\d)\d*(?:\.\d*)?(?:[Ee](?:[+-]?\d+))?)// ) {
        return ( 'FLOAT', $1 );
      } elsif( $$buf =~ s/^( \%}
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
      } elsif( $$buf =~ s/^(#.*)(?:\r\n|\r|\n)// ) {
        return ( 'RAW_CODE', $1 );
      } else {
        warn $$buf;
      }
    }
  }
}

sub yyerror {
  my $data = $_[0]->YYData->{LEX};
  my $buf = $data->{BUFFER};
  my $fh = $data->{FH};
   
  print STDERR "Error: line " . $fh->input_line_number . " (",
    $_[0]->YYCurtok, ') (',
    $_[0]->YYCurval, ') "', ( $buf ? $$buf : '--empty buffer--' ),
      q{"} . "\n";
  print STDERR "Expecting: (", ( join ", ", map { "'$_'" } $_[0]->YYExpect ),
        ")\n";
}

sub make_cptr { Wx::XSP::Node::Type->new( base => $_[1],
                                        const => 1, pointer => 1 ) }
sub make_cref { Wx::XSP::Node::Type->new( base => $_[1],
                                        const => 1, reference => 1 ) }
sub make_ref  { Wx::XSP::Node::Type->new( base => $_[1], reference => 1 ) }
sub make_ptr  { Wx::XSP::Node::Type->new( base => $_[1], pointer => 1 ) }
sub make_type { Wx::XSP::Node::Type->new( base => $_[1] ) }

sub add_data_raw {
  my $p = shift;
  my $rows = shift;

  Wx::XSP::Node::Raw->new( rows => $rows );
}

sub make_argument {
  my( $p, $type, $name, $default ) = @_;

  Wx::XSP::Node::Argument->new( type    => $type,
                              name    => $name,
                              default => $default );
}

sub add_data_class {
  my( $parser, %args ) = @_;

  my $class = Wx::XSP::Node::Class->new( perl_name => $args{perl},
                                       cpp_name => $args{class},
                                       methods => $args{methods} );

  foreach my $m ( @{$class->methods} ) { $m->{CLASS} = $class }

  $class;
}

sub add_data_function {
  my( $parser, %args ) = @_;

  Wx::XSP::Node::Function->new( cpp_name  => $args{name},
                              ret_type  => $args{ret_type},
                              arguments => $args{arguments},
                              code      => $args{code} );
}

sub add_data_method {
  my( $parser, %args ) = @_;

  Wx::XSP::Node::Method->new( cpp_name  => $args{name},
                            ret_type  => $args{ret_type},
                            arguments => $args{arguments},
                            code      => $args{code} );
}

sub add_data_ctor {
  my( $parser, %args ) = @_;

  Wx::XSP::Node::Constructor->new( cpp_name  => $args{name},
                                 arguments => $args{arguments},
                                 code      => $args{code} );
}

sub add_data_dtor {
  my( $parser, $name ) = @_;

  Wx::XSP::Node::Destructor->new( cpp_name => $name ); 
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
