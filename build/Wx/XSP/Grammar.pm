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
			'p_module' => 17,
			'p_typemap' => 3,
			'OPSPECIAL' => 5,
			"short" => 21,
			"class" => 8,
			'p_file' => 22,
			'RAW_CODE' => 9,
			'p_name' => 25,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'class_name' => 2,
			'function' => 4,
			'special_block_start' => 6,
			'perc_name' => 7,
			'typemap' => 10,
			'special_block' => 12,
			'perc_module' => 14,
			'type_name' => 15,
			'basic_type' => 16,
			'perc_file' => 18,
			'_func' => 19,
			'class_head' => 20,
			'top' => 23,
			'directive' => 27,
			'class' => 28,
			'type' => 29,
			'raw' => 31
		}
	},
	{#State 1
		ACTIONS => {
			'DCOLON' => 32
		},
		DEFAULT => -65
	},
	{#State 2
		DEFAULT => -55
	},
	{#State 3
		ACTIONS => {
			'OPCURLY' => 33
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		DEFAULT => -85
	},
	{#State 6
		ACTIONS => {
			'CLSPECIAL' => 35,
			'line' => 36
		},
		GOTOS => {
			'special_block_end' => 37,
			'lines' => 34
		}
	},
	{#State 7
		ACTIONS => {
			'ID' => 1,
			"short" => 21,
			"class" => 38,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'basic_type' => 16,
			'_func' => 39,
			'type' => 29
		}
	},
	{#State 8
		ACTIONS => {
			'ID' => 40
		}
	},
	{#State 9
		DEFAULT => -14
	},
	{#State 10
		ACTIONS => {
			'SEMICOLON' => 41
		}
	},
	{#State 11
		ACTIONS => {
			'ID' => 1,
			"short" => 21,
			"unsigned" => 24,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 42,
			'class_name' => 2,
			'basic_type' => 16
		}
	},
	{#State 12
		DEFAULT => -15
	},
	{#State 13
		DEFAULT => -60
	},
	{#State 14
		ACTIONS => {
			'SEMICOLON' => 43
		}
	},
	{#State 15
		ACTIONS => {
			'STAR' => 45,
			'AMP' => 44
		},
		DEFAULT => -54
	},
	{#State 16
		DEFAULT => -56
	},
	{#State 17
		ACTIONS => {
			'OPCURLY' => 46
		}
	},
	{#State 18
		ACTIONS => {
			'SEMICOLON' => 47
		}
	},
	{#State 19
		DEFAULT => -33
	},
	{#State 20
		ACTIONS => {
			'OPCURLY' => 48
		},
		GOTOS => {
			'class_body' => 49
		}
	},
	{#State 21
		ACTIONS => {
			"int" => 50
		},
		DEFAULT => -59
	},
	{#State 22
		ACTIONS => {
			'OPCURLY' => 51
		}
	},
	{#State 23
		ACTIONS => {
			'' => 52,
			'ID' => 1,
			'p_module' => 17,
			'p_typemap' => 3,
			'OPSPECIAL' => 5,
			"short" => 21,
			"class" => 8,
			'p_file' => 22,
			'RAW_CODE' => 9,
			'p_name' => 25,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'perc_file' => 18,
			'basic_type' => 16,
			'function' => 53,
			'_func' => 19,
			'special_block_start' => 6,
			'class_head' => 20,
			'perc_name' => 7,
			'typemap' => 10,
			'class' => 55,
			'directive' => 54,
			'type' => 29,
			'special_block' => 12,
			'perc_module' => 14,
			'raw' => 56
		}
	},
	{#State 24
		ACTIONS => {
			"short" => 21,
			"unsigned" => 58,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		DEFAULT => -62,
		GOTOS => {
			'basic_type' => 57
		}
	},
	{#State 25
		ACTIONS => {
			'OPCURLY' => 59
		}
	},
	{#State 26
		ACTIONS => {
			"int" => 60
		},
		DEFAULT => -61
	},
	{#State 27
		DEFAULT => -3
	},
	{#State 28
		DEFAULT => -2
	},
	{#State 29
		ACTIONS => {
			'ID' => 61
		}
	},
	{#State 30
		DEFAULT => -58
	},
	{#State 31
		DEFAULT => -1
	},
	{#State 32
		ACTIONS => {
			'ID' => 62
		}
	},
	{#State 33
		ACTIONS => {
			'ID' => 1,
			"short" => 21,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 63
		}
	},
	{#State 34
		ACTIONS => {
			'CLSPECIAL' => 35,
			'line' => 64
		},
		GOTOS => {
			'special_block_end' => 65
		}
	},
	{#State 35
		DEFAULT => -86
	},
	{#State 36
		DEFAULT => -87
	},
	{#State 37
		DEFAULT => -84
	},
	{#State 38
		ACTIONS => {
			'ID' => 66
		}
	},
	{#State 39
		DEFAULT => -34
	},
	{#State 40
		DEFAULT => -18
	},
	{#State 41
		DEFAULT => -11
	},
	{#State 42
		ACTIONS => {
			'STAR' => 68,
			'AMP' => 67
		}
	},
	{#State 43
		DEFAULT => -9
	},
	{#State 44
		DEFAULT => -53
	},
	{#State 45
		DEFAULT => -52
	},
	{#State 46
		ACTIONS => {
			'ID' => 1
		},
		GOTOS => {
			'class_name' => 69
		}
	},
	{#State 47
		DEFAULT => -10
	},
	{#State 48
		ACTIONS => {
			'ID' => 70,
			'p_typemap' => 3,
			'OPSPECIAL' => 5,
			'CLCURLY' => 77,
			"short" => 21,
			'RAW_CODE' => 9,
			'TILDE' => 78,
			'p_name' => 25,
			"const" => 11,
			"unsigned" => 24,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 76,
			'basic_type' => 16,
			'function' => 71,
			'_func' => 19,
			'special_block_start' => 6,
			'perc_name' => 72,
			'typemap' => 73,
			'methods' => 74,
			'dtor' => 79,
			'type' => 29,
			'method' => 75,
			'special_block' => 12,
			'raw' => 80
		}
	},
	{#State 49
		DEFAULT => -16
	},
	{#State 50
		DEFAULT => -64
	},
	{#State 51
		ACTIONS => {
			'ID' => 81,
			'DASH' => 83
		},
		GOTOS => {
			'file_name' => 82
		}
	},
	{#State 52
		DEFAULT => 0
	},
	{#State 53
		DEFAULT => -8
	},
	{#State 54
		DEFAULT => -7
	},
	{#State 55
		DEFAULT => -6
	},
	{#State 56
		DEFAULT => -5
	},
	{#State 57
		DEFAULT => -57
	},
	{#State 58
		DEFAULT => -62
	},
	{#State 59
		ACTIONS => {
			'ID' => 1
		},
		GOTOS => {
			'class_name' => 84
		}
	},
	{#State 60
		DEFAULT => -63
	},
	{#State 61
		ACTIONS => {
			'OPPAR' => 85
		}
	},
	{#State 62
		DEFAULT => -66
	},
	{#State 63
		ACTIONS => {
			'CLCURLY' => 86
		}
	},
	{#State 64
		DEFAULT => -88
	},
	{#State 65
		DEFAULT => -83
	},
	{#State 66
		DEFAULT => -17
	},
	{#State 67
		DEFAULT => -51
	},
	{#State 68
		DEFAULT => -50
	},
	{#State 69
		ACTIONS => {
			'CLCURLY' => 87
		}
	},
	{#State 70
		ACTIONS => {
			'DCOLON' => 32,
			'OPPAR' => 88
		},
		DEFAULT => -65
	},
	{#State 71
		DEFAULT => -27
	},
	{#State 72
		ACTIONS => {
			'ID' => 70,
			"short" => 21,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 89,
			'basic_type' => 16,
			'_func' => 39,
			'type' => 29
		}
	},
	{#State 73
		ACTIONS => {
			'SEMICOLON' => 90
		}
	},
	{#State 74
		ACTIONS => {
			'ID' => 70,
			'p_typemap' => 3,
			'OPSPECIAL' => 5,
			'CLCURLY' => 93,
			"short" => 21,
			'RAW_CODE' => 9,
			'TILDE' => 78,
			'p_name' => 25,
			"const" => 11,
			"unsigned" => 24,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'class_name' => 2,
			'ctor' => 76,
			'basic_type' => 16,
			'function' => 71,
			'_func' => 19,
			'special_block_start' => 6,
			'perc_name' => 72,
			'typemap' => 91,
			'dtor' => 79,
			'type' => 29,
			'special_block' => 12,
			'method' => 92,
			'raw' => 94
		}
	},
	{#State 75
		DEFAULT => -21
	},
	{#State 76
		DEFAULT => -28
	},
	{#State 77
		ACTIONS => {
			'SEMICOLON' => 95
		}
	},
	{#State 78
		ACTIONS => {
			'ID' => 96
		}
	},
	{#State 79
		DEFAULT => -30
	},
	{#State 80
		DEFAULT => -23
	},
	{#State 81
		ACTIONS => {
			'DOT' => 98,
			'SLASH' => 97
		}
	},
	{#State 82
		ACTIONS => {
			'CLCURLY' => 99
		}
	},
	{#State 83
		DEFAULT => -67
	},
	{#State 84
		ACTIONS => {
			'CLCURLY' => 100
		}
	},
	{#State 85
		ACTIONS => {
			'ID' => 1,
			'CLPAR' => 103,
			"short" => 21,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'argument' => 102,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 104,
			'arg_list' => 101
		}
	},
	{#State 86
		ACTIONS => {
			'OPCURLY' => 105
		}
	},
	{#State 87
		DEFAULT => -46
	},
	{#State 88
		ACTIONS => {
			'ID' => 1,
			'CLPAR' => 107,
			"short" => 21,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'argument' => 102,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 104,
			'arg_list' => 106
		}
	},
	{#State 89
		DEFAULT => -29
	},
	{#State 90
		DEFAULT => -25
	},
	{#State 91
		ACTIONS => {
			'SEMICOLON' => 108
		}
	},
	{#State 92
		DEFAULT => -22
	},
	{#State 93
		ACTIONS => {
			'SEMICOLON' => 109
		}
	},
	{#State 94
		DEFAULT => -24
	},
	{#State 95
		DEFAULT => -20
	},
	{#State 96
		ACTIONS => {
			'OPPAR' => 110
		}
	},
	{#State 97
		ACTIONS => {
			'ID' => 81,
			'DASH' => 83
		},
		GOTOS => {
			'file_name' => 111
		}
	},
	{#State 98
		ACTIONS => {
			'ID' => 112
		}
	},
	{#State 99
		DEFAULT => -47
	},
	{#State 100
		DEFAULT => -45
	},
	{#State 101
		ACTIONS => {
			'CLPAR' => 114,
			'COMMA' => 113
		}
	},
	{#State 102
		DEFAULT => -70
	},
	{#State 103
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117
		},
		DEFAULT => -42,
		GOTOS => {
			'_metadata' => 119,
			'perc_code' => 115,
			'perc_cleanup' => 120,
			'metadata' => 118
		}
	},
	{#State 104
		ACTIONS => {
			'ID' => 121
		}
	},
	{#State 105
		ACTIONS => {
			'ID' => 122
		}
	},
	{#State 106
		ACTIONS => {
			'CLPAR' => 123,
			'COMMA' => 113
		}
	},
	{#State 107
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117
		},
		DEFAULT => -42,
		GOTOS => {
			'_metadata' => 119,
			'perc_code' => 115,
			'perc_cleanup' => 120,
			'metadata' => 124
		}
	},
	{#State 108
		DEFAULT => -26
	},
	{#State 109
		DEFAULT => -19
	},
	{#State 110
		ACTIONS => {
			'CLPAR' => 125
		}
	},
	{#State 111
		DEFAULT => -69
	},
	{#State 112
		DEFAULT => -68
	},
	{#State 113
		ACTIONS => {
			'ID' => 1,
			"short" => 21,
			"unsigned" => 24,
			"const" => 11,
			"long" => 26,
			"int" => 13,
			"char" => 30
		},
		GOTOS => {
			'type_name' => 15,
			'argument' => 126,
			'class_name' => 2,
			'basic_type' => 16,
			'type' => 104
		}
	},
	{#State 114
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117
		},
		DEFAULT => -42,
		GOTOS => {
			'_metadata' => 119,
			'perc_code' => 115,
			'perc_cleanup' => 120,
			'metadata' => 127
		}
	},
	{#State 115
		DEFAULT => -43
	},
	{#State 116
		ACTIONS => {
			'OPSPECIAL' => 5
		},
		GOTOS => {
			'special_block' => 128,
			'special_block_start' => 6
		}
	},
	{#State 117
		ACTIONS => {
			'OPSPECIAL' => 5
		},
		GOTOS => {
			'special_block' => 129,
			'special_block_start' => 6
		}
	},
	{#State 118
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117,
			"const" => 130
		},
		DEFAULT => -32,
		GOTOS => {
			'_metadata' => 131,
			'perc_code' => 115,
			'const' => 132,
			'perc_cleanup' => 120
		}
	},
	{#State 119
		DEFAULT => -40
	},
	{#State 120
		DEFAULT => -44
	},
	{#State 121
		ACTIONS => {
			'EQUAL' => 133
		},
		DEFAULT => -72
	},
	{#State 122
		ACTIONS => {
			'CLCURLY' => 134
		}
	},
	{#State 123
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117
		},
		DEFAULT => -42,
		GOTOS => {
			'_metadata' => 119,
			'perc_code' => 115,
			'perc_cleanup' => 120,
			'metadata' => 135
		}
	},
	{#State 124
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117,
			'SEMICOLON' => 136
		},
		GOTOS => {
			'_metadata' => 131,
			'perc_code' => 115,
			'perc_cleanup' => 120
		}
	},
	{#State 125
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117
		},
		DEFAULT => -42,
		GOTOS => {
			'_metadata' => 119,
			'perc_code' => 115,
			'perc_cleanup' => 120,
			'metadata' => 137
		}
	},
	{#State 126
		DEFAULT => -71
	},
	{#State 127
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117,
			"const" => 130
		},
		DEFAULT => -32,
		GOTOS => {
			'_metadata' => 131,
			'perc_code' => 115,
			'const' => 138,
			'perc_cleanup' => 120
		}
	},
	{#State 128
		DEFAULT => -48
	},
	{#State 129
		DEFAULT => -49
	},
	{#State 130
		DEFAULT => -31
	},
	{#State 131
		DEFAULT => -41
	},
	{#State 132
		ACTIONS => {
			'SEMICOLON' => 139
		}
	},
	{#State 133
		ACTIONS => {
			'INTEGER' => 143,
			'ID' => 140,
			'QUOTED_STRING' => 145,
			'DASH' => 142,
			'FLOAT' => 141
		},
		GOTOS => {
			'value' => 144
		}
	},
	{#State 134
		ACTIONS => {
			'OPSPECIAL' => 5
		},
		DEFAULT => -12,
		GOTOS => {
			'special_blocks' => 146,
			'special_block' => 147,
			'special_block_start' => 6
		}
	},
	{#State 135
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117,
			'SEMICOLON' => 148
		},
		GOTOS => {
			'_metadata' => 131,
			'perc_code' => 115,
			'perc_cleanup' => 120
		}
	},
	{#State 136
		DEFAULT => -38
	},
	{#State 137
		ACTIONS => {
			'p_code' => 116,
			'p_cleanup' => 117,
			'SEMICOLON' => 149
		},
		GOTOS => {
			'_metadata' => 131,
			'perc_code' => 115,
			'perc_cleanup' => 120
		}
	},
	{#State 138
		ACTIONS => {
			'SEMICOLON' => 150
		}
	},
	{#State 139
		DEFAULT => -36
	},
	{#State 140
		ACTIONS => {
			'DCOLON' => 151,
			'OPPAR' => 152
		},
		DEFAULT => -78
	},
	{#State 141
		DEFAULT => -76
	},
	{#State 142
		ACTIONS => {
			'INTEGER' => 153
		}
	},
	{#State 143
		DEFAULT => -74
	},
	{#State 144
		DEFAULT => -73
	},
	{#State 145
		DEFAULT => -77
	},
	{#State 146
		ACTIONS => {
			'OPSPECIAL' => 5
		},
		DEFAULT => -13,
		GOTOS => {
			'special_block' => 154,
			'special_block_start' => 6
		}
	},
	{#State 147
		DEFAULT => -81
	},
	{#State 148
		DEFAULT => -37
	},
	{#State 149
		DEFAULT => -39
	},
	{#State 150
		DEFAULT => -35
	},
	{#State 151
		ACTIONS => {
			'ID' => 155
		}
	},
	{#State 152
		ACTIONS => {
			'INTEGER' => 143,
			'ID' => 140,
			'QUOTED_STRING' => 145,
			'DASH' => 142,
			'FLOAT' => 141
		},
		GOTOS => {
			'value' => 156
		}
	},
	{#State 153
		DEFAULT => -75
	},
	{#State 154
		DEFAULT => -82
	},
	{#State 155
		DEFAULT => -79
	},
	{#State 156
		ACTIONS => {
			'CLPAR' => 157
		}
	},
	{#State 157
		DEFAULT => -80
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
                      my $type = $_[3]; my $c = 0;
                      my %args = map { "arg" . ++$c => $_ }
                                 map { join( '', @$_ ) }
                                     @{$_[8]};
                      my $tm = $package->new( type => $type, %args );
                      Wx::XSP::Typemap::add_typemap_for_type( $type, $tm );
                      undef }
	],
	[#Rule 14
		 'raw', 1,
sub
#line 52 "build/Wx/XSP/XSP.yp"
{ add_data_raw( $_[0], [ $_[1] ] ) }
	],
	[#Rule 15
		 'raw', 1,
sub
#line 53 "build/Wx/XSP/XSP.yp"
{ add_data_raw( $_[0], [ @{$_[1]}, '' ] ) }
	],
	[#Rule 16
		 'class', 2,
sub
#line 56 "build/Wx/XSP/XSP.yp"
{ $_[2] ? set_data_class( $_[0],
                                     class   => $_[1],
                                     methods => $_[2] ) : $_[1] }
	],
	[#Rule 17
		 'class_head', 3,
sub
#line 61 "build/Wx/XSP/XSP.yp"
{ $class = create_class( $_[0], $_[3], $_[1] ) }
	],
	[#Rule 18
		 'class_head', 2,
sub
#line 63 "build/Wx/XSP/XSP.yp"
{ $class = create_class( $_[0], $_[2] ) }
	],
	[#Rule 19
		 'class_body', 4,
sub
#line 65 "build/Wx/XSP/XSP.yp"
{ $_[2] }
	],
	[#Rule 20
		 'class_body', 3,
sub
#line 66 "build/Wx/XSP/XSP.yp"
{ undef }
	],
	[#Rule 21
		 'methods', 1,
sub
#line 68 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 22
		 'methods', 2,
sub
#line 69 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 23
		 'methods', 1,
sub
#line 70 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 24
		 'methods', 2,
sub
#line 71 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	],
	[#Rule 25
		 'methods', 2, undef
	],
	[#Rule 26
		 'methods', 3, undef
	],
	[#Rule 27
		 'method', 1,
sub
#line 76 "build/Wx/XSP/XSP.yp"
{ my $f = $_[1];
                           my $m = add_data_method
                             ( $_[0],
                               name      => $f->cpp_name,
                               ret_type  => $f->ret_type,
                               arguments => $f->arguments,
                               code      => $f->code,
                               cleanup   => $f->cleanup,
                               class     => $class,
                               );
                           $m->{PERL_NAME} = $_[1]->{PERL_NAME};
                           $m
                         }
	],
	[#Rule 28
		 'method', 1, undef
	],
	[#Rule 29
		 'method', 2,
sub
#line 91 "build/Wx/XSP/XSP.yp"
{ $_[2]->{PERL_NAME} = $_[1]; $_[2] }
	],
	[#Rule 30
		 'method', 1, undef
	],
	[#Rule 31
		 'const', 1, undef
	],
	[#Rule 32
		 'const', 0, undef
	],
	[#Rule 33
		 'function', 1, undef
	],
	[#Rule 34
		 'function', 2,
sub
#line 99 "build/Wx/XSP/XSP.yp"
{ $_[2]->{PERL_NAME} = $_[1]; $_[2] }
	],
	[#Rule 35
		 '_func', 8,
sub
#line 103 "build/Wx/XSP/XSP.yp"
{ add_data_function( $_[0],
                                         name      => $_[2],
                                         ret_type  => $_[1],
                                         arguments => $_[4],
                                         class     => $class,
                                         @{ $_[6] } ) }
	],
	[#Rule 36
		 '_func', 7,
sub
#line 110 "build/Wx/XSP/XSP.yp"
{ add_data_function( $_[0],
                                         name     => $_[2],
                                         ret_type => $_[1],
                                         class     => $class,
                                         @{ $_[5] } ) }
	],
	[#Rule 37
		 'ctor', 6,
sub
#line 117 "build/Wx/XSP/XSP.yp"
{ add_data_ctor( $_[0], name      => $_[1],
                                            arguments => $_[3],
                                            class     => $class,
                                            @{ $_[5] } ) }
	],
	[#Rule 38
		 'ctor', 5,
sub
#line 122 "build/Wx/XSP/XSP.yp"
{ add_data_ctor( $_[0], name  => $_[1],
                                            class => $class,
                                            @{ $_[4] } ) }
	],
	[#Rule 39
		 'dtor', 6,
sub
#line 127 "build/Wx/XSP/XSP.yp"
{ add_data_dtor( $_[0], name  => $_[2],
                                            class => $class,
                                            @{ $_[5] },
                                      ) }
	],
	[#Rule 40
		 'metadata', 1,
sub
#line 132 "build/Wx/XSP/XSP.yp"
{ $_[1] }
	],
	[#Rule 41
		 'metadata', 2,
sub
#line 133 "build/Wx/XSP/XSP.yp"
{ [ @{$_[1]}, @{$_[2]} ] }
	],
	[#Rule 42
		 'metadata', 0,
sub
#line 134 "build/Wx/XSP/XSP.yp"
{ [] }
	],
	[#Rule 43
		 '_metadata', 1,
sub
#line 137 "build/Wx/XSP/XSP.yp"
{ $_[1] }
	],
	[#Rule 44
		 '_metadata', 1,
sub
#line 138 "build/Wx/XSP/XSP.yp"
{ $_[1] }
	],
	[#Rule 45
		 'perc_name', 4,
sub
#line 141 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 46
		 'perc_module', 4,
sub
#line 142 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 47
		 'perc_file', 4,
sub
#line 143 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 48
		 'perc_code', 2,
sub
#line 144 "build/Wx/XSP/XSP.yp"
{ [ code => $_[2] ] }
	],
	[#Rule 49
		 'perc_cleanup', 2,
sub
#line 145 "build/Wx/XSP/XSP.yp"
{ [ cleanup => $_[2] ] }
	],
	[#Rule 50
		 'type', 3,
sub
#line 147 "build/Wx/XSP/XSP.yp"
{ make_cptr( $_[0], $_[2] ) }
	],
	[#Rule 51
		 'type', 3,
sub
#line 148 "build/Wx/XSP/XSP.yp"
{ make_cref( $_[0], $_[2] ) }
	],
	[#Rule 52
		 'type', 2,
sub
#line 149 "build/Wx/XSP/XSP.yp"
{ make_ptr( $_[0], $_[1] ) }
	],
	[#Rule 53
		 'type', 2,
sub
#line 150 "build/Wx/XSP/XSP.yp"
{ make_ref( $_[0], $_[1] ) }
	],
	[#Rule 54
		 'type', 1,
sub
#line 151 "build/Wx/XSP/XSP.yp"
{ make_type( $_[0], $_[1] ) }
	],
	[#Rule 55
		 'type_name', 1, undef
	],
	[#Rule 56
		 'type_name', 1, undef
	],
	[#Rule 57
		 'type_name', 2, undef
	],
	[#Rule 58
		 'basic_type', 1, undef
	],
	[#Rule 59
		 'basic_type', 1, undef
	],
	[#Rule 60
		 'basic_type', 1, undef
	],
	[#Rule 61
		 'basic_type', 1, undef
	],
	[#Rule 62
		 'basic_type', 1, undef
	],
	[#Rule 63
		 'basic_type', 2, undef
	],
	[#Rule 64
		 'basic_type', 2, undef
	],
	[#Rule 65
		 'class_name', 1, undef
	],
	[#Rule 66
		 'class_name', 3,
sub
#line 159 "build/Wx/XSP/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 67
		 'file_name', 1,
sub
#line 161 "build/Wx/XSP/XSP.yp"
{ '-' }
	],
	[#Rule 68
		 'file_name', 3,
sub
#line 162 "build/Wx/XSP/XSP.yp"
{ $_[1] . '.' . $_[3] }
	],
	[#Rule 69
		 'file_name', 3,
sub
#line 163 "build/Wx/XSP/XSP.yp"
{ $_[1] . '/' . $_[3] }
	],
	[#Rule 70
		 'arg_list', 1,
sub
#line 165 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 71
		 'arg_list', 3,
sub
#line 166 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[3]; $_[1] }
	],
	[#Rule 72
		 'argument', 2,
sub
#line 168 "build/Wx/XSP/XSP.yp"
{ make_argument( @_ ) }
	],
	[#Rule 73
		 'argument', 4,
sub
#line 170 "build/Wx/XSP/XSP.yp"
{ make_argument( @_[0, 1, 2, 4] ) }
	],
	[#Rule 74
		 'value', 1, undef
	],
	[#Rule 75
		 'value', 2,
sub
#line 173 "build/Wx/XSP/XSP.yp"
{ '-' . $_[2] }
	],
	[#Rule 76
		 'value', 1, undef
	],
	[#Rule 77
		 'value', 1, undef
	],
	[#Rule 78
		 'value', 1, undef
	],
	[#Rule 79
		 'value', 3,
sub
#line 177 "build/Wx/XSP/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 80
		 'value', 4,
sub
#line 178 "build/Wx/XSP/XSP.yp"
{ "$_[1]($_[3])" }
	],
	[#Rule 81
		 'special_blocks', 1,
sub
#line 183 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 82
		 'special_blocks', 2,
sub
#line 185 "build/Wx/XSP/XSP.yp"
{ [ @{$_[1]}, $_[2] ] }
	],
	[#Rule 83
		 'special_block', 3,
sub
#line 189 "build/Wx/XSP/XSP.yp"
{ $_[2] }
	],
	[#Rule 84
		 'special_block', 2,
sub
#line 191 "build/Wx/XSP/XSP.yp"
{ [] }
	],
	[#Rule 85
		 'special_block_start', 1,
sub
#line 194 "build/Wx/XSP/XSP.yp"
{ push_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 86
		 'special_block_end', 1,
sub
#line 196 "build/Wx/XSP/XSP.yp"
{ pop_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 87
		 'lines', 1,
sub
#line 198 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 88
		 'lines', 2,
sub
#line 199 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	]
],
                                  @_);
    bless($self,$class);
}

#line 201 "build/Wx/XSP/XSP.yp"


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
               '%cleanup' => 'p_cleanup',
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
                      | \%file | \%cleanup
                      | [{}();%~*&,=\/\.\-]
                      | ::
                       )//x ) {
        return ( $tokens{$1}, $1 );
      } elsif( $$buf =~ s/^(INCLUDE:.*)(?:\r\n|\r|\n)// ) {
        return ( 'RAW_CODE', $1 );
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
        die $$buf;
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

sub create_class {
  my( $parser, $name, $perl ) = @_;
  my $class = Wx::XSP::Node::Class->new( perl_name => $perl,
                                         cpp_name  => $name,
                                         );
  return $class;
}

sub set_data_class {
  my( $parser, %args ) = @_;
  $args{class}->{METHODS} = $args{methods};

  return $args{class};
}

sub add_data_function {
  my( $parser, %args ) = @_;

  Wx::XSP::Node::Function->new( cpp_name  => $args{name},
                                class     => $args{class},
                                ret_type  => $args{ret_type},
                                arguments => $args{arguments},
                                code      => $args{code},
                                cleanup   => $args{cleanup},
                                );
}

sub add_data_method {
  my( $parser, %args ) = @_;

  die "PANIC: method $args{name} without class" unless $args{class};
  Wx::XSP::Node::Method->new( cpp_name  => $args{name},
                              class     => $args{class},
                              ret_type  => $args{ret_type},
                              arguments => $args{arguments},
                              code      => $args{code},
                              cleanup   => $args{cleanup},
                              );
}

sub add_data_ctor {
  my( $parser, %args ) = @_;

  die "PANIC: constructor $args{name} without class" unless $args{class};
  Wx::XSP::Node::Constructor->new( cpp_name  => $args{name},
                                   class     => $args{class},
                                   arguments => $args{arguments},
                                   code      => $args{code},
                                   );
}

sub add_data_dtor {
  my( $parser, %args ) = @_;

  die "PANIC: destructor $args{name} without class" unless $args{class};
  Wx::XSP::Node::Destructor->new( cpp_name  => $args{name},
                                  class     => $args{class},
                                  code      => $args{code},
                                  );
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
