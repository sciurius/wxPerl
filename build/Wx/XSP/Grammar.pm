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
			'ID' => 20,
			'p_typemap' => 2,
			'OPSPECIAL' => 22,
			"class_static" => 4,
			"package_static" => 23,
			"class" => 6,
			'RAW_CODE' => 25,
			"const" => 8,
			"int" => 27,
			'p_module' => 11,
			"short" => 13,
			'p_file' => 31,
			'p_name' => 15,
			"unsigned" => 32,
			"long" => 16,
			"char" => 19
		},
		GOTOS => {
			'class_name' => 1,
			'function' => 21,
			'static' => 3,
			'special_block_start' => 24,
			'perc_name' => 5,
			'typemap' => 7,
			'special_block' => 9,
			'perc_module' => 26,
			'type_name' => 10,
			'perc_file' => 28,
			'basic_type' => 29,
			'_func' => 30,
			'class_head' => 12,
			'top' => 14,
			'type' => 17,
			'class' => 18,
			'directive' => 33,
			'raw' => 34
		}
	},
	{#State 1
		DEFAULT => -59
	},
	{#State 2
		ACTIONS => {
			'OPCURLY' => 35
		}
	},
	{#State 3
		ACTIONS => {
			'ID' => 20,
			"short" => 13,
			"unsigned" => 32,
			"const" => 8,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 10,
			'class_name' => 1,
			'basic_type' => 29,
			'_func' => 36,
			'type' => 17
		}
	},
	{#State 4
		DEFAULT => -34
	},
	{#State 5
		ACTIONS => {
			'ID' => 20,
			"class_static" => 4,
			"package_static" => 23,
			"class" => 38,
			"short" => 13,
			"unsigned" => 32,
			"const" => 8,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 10,
			'class_name' => 1,
			'basic_type' => 29,
			'_func' => 39,
			'type' => 17,
			'static' => 37
		}
	},
	{#State 6
		ACTIONS => {
			'ID' => 40
		}
	},
	{#State 7
		ACTIONS => {
			'SEMICOLON' => 41
		}
	},
	{#State 8
		ACTIONS => {
			'ID' => 20,
			"short" => 13,
			"unsigned" => 32,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 42,
			'class_name' => 1,
			'basic_type' => 29
		}
	},
	{#State 9
		DEFAULT => -15
	},
	{#State 10
		ACTIONS => {
			'STAR' => 44,
			'AMP' => 43
		},
		DEFAULT => -58
	},
	{#State 11
		ACTIONS => {
			'OPCURLY' => 45
		}
	},
	{#State 12
		ACTIONS => {
			'OPCURLY' => 46
		},
		GOTOS => {
			'class_body' => 47
		}
	},
	{#State 13
		ACTIONS => {
			"int" => 48
		},
		DEFAULT => -63
	},
	{#State 14
		ACTIONS => {
			'ID' => 20,
			'' => 49,
			'p_typemap' => 2,
			'OPSPECIAL' => 22,
			"class_static" => 4,
			"package_static" => 23,
			"class" => 6,
			'RAW_CODE' => 25,
			"const" => 8,
			"int" => 27,
			'p_module' => 11,
			"short" => 13,
			'p_file' => 31,
			"unsigned" => 32,
			'p_name' => 15,
			"long" => 16,
			"char" => 19
		},
		GOTOS => {
			'class_name' => 1,
			'function' => 51,
			'static' => 3,
			'special_block_start' => 24,
			'perc_name' => 5,
			'typemap' => 7,
			'special_block' => 9,
			'perc_module' => 26,
			'type_name' => 10,
			'basic_type' => 29,
			'perc_file' => 28,
			'_func' => 30,
			'class_head' => 12,
			'type' => 17,
			'class' => 50,
			'directive' => 52,
			'raw' => 53
		}
	},
	{#State 15
		ACTIONS => {
			'OPCURLY' => 54
		}
	},
	{#State 16
		ACTIONS => {
			"int" => 55
		},
		DEFAULT => -65
	},
	{#State 17
		ACTIONS => {
			'ID' => 56
		}
	},
	{#State 18
		DEFAULT => -2
	},
	{#State 19
		DEFAULT => -62
	},
	{#State 20
		ACTIONS => {
			'DCOLON' => 57
		},
		DEFAULT => -69
	},
	{#State 21
		DEFAULT => -4
	},
	{#State 22
		DEFAULT => -89
	},
	{#State 23
		DEFAULT => -33
	},
	{#State 24
		ACTIONS => {
			'CLSPECIAL' => 58,
			'line' => 59
		},
		GOTOS => {
			'special_block_end' => 60,
			'lines' => 61
		}
	},
	{#State 25
		DEFAULT => -14
	},
	{#State 26
		ACTIONS => {
			'SEMICOLON' => 62
		}
	},
	{#State 27
		DEFAULT => -64
	},
	{#State 28
		ACTIONS => {
			'SEMICOLON' => 63
		}
	},
	{#State 29
		DEFAULT => -60
	},
	{#State 30
		DEFAULT => -35
	},
	{#State 31
		ACTIONS => {
			'OPCURLY' => 64
		}
	},
	{#State 32
		ACTIONS => {
			"short" => 13,
			"unsigned" => 66,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		DEFAULT => -66,
		GOTOS => {
			'basic_type' => 65
		}
	},
	{#State 33
		DEFAULT => -3
	},
	{#State 34
		DEFAULT => -1
	},
	{#State 35
		ACTIONS => {
			'ID' => 20,
			"short" => 13,
			"unsigned" => 32,
			"const" => 8,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 10,
			'class_name' => 1,
			'basic_type' => 29,
			'type' => 67
		}
	},
	{#State 36
		DEFAULT => -36
	},
	{#State 37
		ACTIONS => {
			'ID' => 20,
			"short" => 13,
			"unsigned" => 32,
			"const" => 8,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 10,
			'class_name' => 1,
			'basic_type' => 29,
			'_func' => 68,
			'type' => 17
		}
	},
	{#State 38
		ACTIONS => {
			'ID' => 69
		}
	},
	{#State 39
		DEFAULT => -37
	},
	{#State 40
		DEFAULT => -18
	},
	{#State 41
		DEFAULT => -11
	},
	{#State 42
		ACTIONS => {
			'STAR' => 71,
			'AMP' => 70
		}
	},
	{#State 43
		DEFAULT => -57
	},
	{#State 44
		DEFAULT => -56
	},
	{#State 45
		ACTIONS => {
			'ID' => 20
		},
		GOTOS => {
			'class_name' => 72
		}
	},
	{#State 46
		ACTIONS => {
			'ID' => 79,
			'p_typemap' => 2,
			'OPSPECIAL' => 22,
			"class_static" => 4,
			"package_static" => 23,
			'CLCURLY' => 82,
			"short" => 13,
			'RAW_CODE' => 25,
			"unsigned" => 32,
			"const" => 8,
			'p_name' => 15,
			'TILDE' => 77,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 10,
			'class_name' => 1,
			'ctor' => 76,
			'basic_type' => 29,
			'function' => 80,
			'_func' => 30,
			'static' => 3,
			'special_block_start' => 24,
			'perc_name' => 73,
			'typemap' => 74,
			'methods' => 75,
			'method' => 81,
			'dtor' => 78,
			'special_block' => 9,
			'type' => 17,
			'raw' => 83
		}
	},
	{#State 47
		DEFAULT => -16
	},
	{#State 48
		DEFAULT => -68
	},
	{#State 49
		DEFAULT => 0
	},
	{#State 50
		DEFAULT => -6
	},
	{#State 51
		DEFAULT => -8
	},
	{#State 52
		DEFAULT => -7
	},
	{#State 53
		DEFAULT => -5
	},
	{#State 54
		ACTIONS => {
			'ID' => 20
		},
		GOTOS => {
			'class_name' => 84
		}
	},
	{#State 55
		DEFAULT => -67
	},
	{#State 56
		ACTIONS => {
			'OPPAR' => 85
		}
	},
	{#State 57
		ACTIONS => {
			'ID' => 86
		}
	},
	{#State 58
		DEFAULT => -90
	},
	{#State 59
		DEFAULT => -91
	},
	{#State 60
		DEFAULT => -88
	},
	{#State 61
		ACTIONS => {
			'CLSPECIAL' => 58,
			'line' => 87
		},
		GOTOS => {
			'special_block_end' => 88
		}
	},
	{#State 62
		DEFAULT => -9
	},
	{#State 63
		DEFAULT => -10
	},
	{#State 64
		ACTIONS => {
			'ID' => 90,
			'DASH' => 91
		},
		GOTOS => {
			'file_name' => 89
		}
	},
	{#State 65
		DEFAULT => -61
	},
	{#State 66
		DEFAULT => -66
	},
	{#State 67
		ACTIONS => {
			'CLCURLY' => 92
		}
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		DEFAULT => -17
	},
	{#State 70
		DEFAULT => -55
	},
	{#State 71
		DEFAULT => -54
	},
	{#State 72
		ACTIONS => {
			'CLCURLY' => 93
		}
	},
	{#State 73
		ACTIONS => {
			'ID' => 79,
			"class_static" => 4,
			"package_static" => 23,
			"short" => 13,
			"unsigned" => 32,
			"const" => 8,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 10,
			'class_name' => 1,
			'ctor' => 94,
			'basic_type' => 29,
			'_func' => 39,
			'type' => 17,
			'static' => 37
		}
	},
	{#State 74
		ACTIONS => {
			'SEMICOLON' => 95
		}
	},
	{#State 75
		ACTIONS => {
			'ID' => 79,
			'p_typemap' => 2,
			'OPSPECIAL' => 22,
			"class_static" => 4,
			"package_static" => 23,
			'CLCURLY' => 98,
			"short" => 13,
			'RAW_CODE' => 25,
			"unsigned" => 32,
			"const" => 8,
			'p_name' => 15,
			'TILDE' => 77,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'type_name' => 10,
			'class_name' => 1,
			'ctor' => 76,
			'basic_type' => 29,
			'function' => 80,
			'_func' => 30,
			'static' => 3,
			'special_block_start' => 24,
			'perc_name' => 73,
			'typemap' => 96,
			'method' => 97,
			'dtor' => 78,
			'special_block' => 9,
			'type' => 17,
			'raw' => 99
		}
	},
	{#State 76
		DEFAULT => -28
	},
	{#State 77
		ACTIONS => {
			'ID' => 100
		}
	},
	{#State 78
		DEFAULT => -30
	},
	{#State 79
		ACTIONS => {
			'DCOLON' => 57,
			'OPPAR' => 101
		},
		DEFAULT => -69
	},
	{#State 80
		DEFAULT => -27
	},
	{#State 81
		DEFAULT => -21
	},
	{#State 82
		ACTIONS => {
			'SEMICOLON' => 102
		}
	},
	{#State 83
		DEFAULT => -23
	},
	{#State 84
		ACTIONS => {
			'CLCURLY' => 103
		}
	},
	{#State 85
		ACTIONS => {
			'ID' => 20,
			"short" => 13,
			'CLPAR' => 104,
			"const" => 8,
			"unsigned" => 32,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'argument' => 107,
			'type_name' => 10,
			'class_name' => 1,
			'basic_type' => 29,
			'type' => 105,
			'arg_list' => 106
		}
	},
	{#State 86
		DEFAULT => -70
	},
	{#State 87
		DEFAULT => -92
	},
	{#State 88
		DEFAULT => -87
	},
	{#State 89
		ACTIONS => {
			'CLCURLY' => 108
		}
	},
	{#State 90
		ACTIONS => {
			'DOT' => 110,
			'SLASH' => 109
		}
	},
	{#State 91
		DEFAULT => -71
	},
	{#State 92
		ACTIONS => {
			'OPCURLY' => 111
		}
	},
	{#State 93
		DEFAULT => -50
	},
	{#State 94
		DEFAULT => -29
	},
	{#State 95
		DEFAULT => -25
	},
	{#State 96
		ACTIONS => {
			'SEMICOLON' => 112
		}
	},
	{#State 97
		DEFAULT => -22
	},
	{#State 98
		ACTIONS => {
			'SEMICOLON' => 113
		}
	},
	{#State 99
		DEFAULT => -24
	},
	{#State 100
		ACTIONS => {
			'OPPAR' => 114
		}
	},
	{#State 101
		ACTIONS => {
			'ID' => 20,
			"short" => 13,
			'CLPAR' => 115,
			"const" => 8,
			"unsigned" => 32,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'argument' => 107,
			'type_name' => 10,
			'class_name' => 1,
			'basic_type' => 29,
			'type' => 105,
			'arg_list' => 116
		}
	},
	{#State 102
		DEFAULT => -20
	},
	{#State 103
		DEFAULT => -49
	},
	{#State 104
		ACTIONS => {
			"const" => 117
		},
		DEFAULT => -32,
		GOTOS => {
			'const' => 118
		}
	},
	{#State 105
		ACTIONS => {
			'ID' => 119
		}
	},
	{#State 106
		ACTIONS => {
			'CLPAR' => 120,
			'COMMA' => 121
		}
	},
	{#State 107
		DEFAULT => -74
	},
	{#State 108
		DEFAULT => -51
	},
	{#State 109
		ACTIONS => {
			'ID' => 90,
			'DASH' => 91
		},
		GOTOS => {
			'file_name' => 122
		}
	},
	{#State 110
		ACTIONS => {
			'ID' => 123
		}
	},
	{#State 111
		ACTIONS => {
			'ID' => 124
		}
	},
	{#State 112
		DEFAULT => -26
	},
	{#State 113
		DEFAULT => -19
	},
	{#State 114
		ACTIONS => {
			'CLPAR' => 125
		}
	},
	{#State 115
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127
		},
		DEFAULT => -46,
		GOTOS => {
			'_metadata' => 129,
			'perc_code' => 126,
			'perc_cleanup' => 131,
			'metadata' => 128
		}
	},
	{#State 116
		ACTIONS => {
			'CLPAR' => 132,
			'COMMA' => 121
		}
	},
	{#State 117
		DEFAULT => -31
	},
	{#State 118
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127
		},
		DEFAULT => -46,
		GOTOS => {
			'_metadata' => 129,
			'perc_code' => 126,
			'perc_cleanup' => 131,
			'metadata' => 133
		}
	},
	{#State 119
		ACTIONS => {
			'EQUAL' => 134
		},
		DEFAULT => -76
	},
	{#State 120
		ACTIONS => {
			"const" => 117
		},
		DEFAULT => -32,
		GOTOS => {
			'const' => 135
		}
	},
	{#State 121
		ACTIONS => {
			'ID' => 20,
			"short" => 13,
			"unsigned" => 32,
			"const" => 8,
			"long" => 16,
			"int" => 27,
			"char" => 19
		},
		GOTOS => {
			'argument' => 136,
			'type_name' => 10,
			'class_name' => 1,
			'basic_type' => 29,
			'type' => 105
		}
	},
	{#State 122
		DEFAULT => -73
	},
	{#State 123
		DEFAULT => -72
	},
	{#State 124
		ACTIONS => {
			'CLCURLY' => 137
		}
	},
	{#State 125
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127
		},
		DEFAULT => -46,
		GOTOS => {
			'_metadata' => 129,
			'perc_code' => 126,
			'perc_cleanup' => 131,
			'metadata' => 138
		}
	},
	{#State 126
		DEFAULT => -47
	},
	{#State 127
		ACTIONS => {
			'OPSPECIAL' => 22
		},
		GOTOS => {
			'special_block' => 139,
			'special_block_start' => 24
		}
	},
	{#State 128
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127,
			'SEMICOLON' => 141
		},
		GOTOS => {
			'_metadata' => 140,
			'perc_code' => 126,
			'perc_cleanup' => 131
		}
	},
	{#State 129
		DEFAULT => -44
	},
	{#State 130
		ACTIONS => {
			'OPSPECIAL' => 22
		},
		GOTOS => {
			'special_block' => 142,
			'special_block_start' => 24
		}
	},
	{#State 131
		DEFAULT => -48
	},
	{#State 132
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127
		},
		DEFAULT => -46,
		GOTOS => {
			'_metadata' => 129,
			'perc_code' => 126,
			'perc_cleanup' => 131,
			'metadata' => 143
		}
	},
	{#State 133
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127,
			'SEMICOLON' => 144
		},
		GOTOS => {
			'_metadata' => 140,
			'perc_code' => 126,
			'perc_cleanup' => 131
		}
	},
	{#State 134
		ACTIONS => {
			'ID' => 148,
			'INTEGER' => 145,
			'QUOTED_STRING' => 147,
			'DASH' => 150,
			'FLOAT' => 149
		},
		GOTOS => {
			'value' => 146
		}
	},
	{#State 135
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127
		},
		DEFAULT => -46,
		GOTOS => {
			'_metadata' => 129,
			'perc_code' => 126,
			'perc_cleanup' => 131,
			'metadata' => 151
		}
	},
	{#State 136
		DEFAULT => -75
	},
	{#State 137
		ACTIONS => {
			'OPSPECIAL' => 22
		},
		DEFAULT => -12,
		GOTOS => {
			'special_blocks' => 153,
			'special_block' => 152,
			'special_block_start' => 24
		}
	},
	{#State 138
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127,
			'SEMICOLON' => 154
		},
		GOTOS => {
			'_metadata' => 140,
			'perc_code' => 126,
			'perc_cleanup' => 131
		}
	},
	{#State 139
		DEFAULT => -53
	},
	{#State 140
		DEFAULT => -45
	},
	{#State 141
		DEFAULT => -42
	},
	{#State 142
		DEFAULT => -52
	},
	{#State 143
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127,
			'SEMICOLON' => 155
		},
		GOTOS => {
			'_metadata' => 140,
			'perc_code' => 126,
			'perc_cleanup' => 131
		}
	},
	{#State 144
		DEFAULT => -40
	},
	{#State 145
		DEFAULT => -78
	},
	{#State 146
		DEFAULT => -77
	},
	{#State 147
		DEFAULT => -81
	},
	{#State 148
		ACTIONS => {
			'DCOLON' => 156,
			'OPPAR' => 157
		},
		DEFAULT => -82
	},
	{#State 149
		DEFAULT => -80
	},
	{#State 150
		ACTIONS => {
			'INTEGER' => 158
		}
	},
	{#State 151
		ACTIONS => {
			'p_code' => 130,
			'p_cleanup' => 127,
			'SEMICOLON' => 159
		},
		GOTOS => {
			'_metadata' => 140,
			'perc_code' => 126,
			'perc_cleanup' => 131
		}
	},
	{#State 152
		DEFAULT => -85
	},
	{#State 153
		ACTIONS => {
			'OPSPECIAL' => 22
		},
		DEFAULT => -13,
		GOTOS => {
			'special_block' => 160,
			'special_block_start' => 24
		}
	},
	{#State 154
		DEFAULT => -43
	},
	{#State 155
		DEFAULT => -41
	},
	{#State 156
		ACTIONS => {
			'ID' => 161
		}
	},
	{#State 157
		ACTIONS => {
			'ID' => 148,
			'INTEGER' => 145,
			'QUOTED_STRING' => 147,
			'DASH' => 150,
			'FLOAT' => 149
		},
		GOTOS => {
			'value' => 162
		}
	},
	{#State 158
		DEFAULT => -79
	},
	{#State 159
		DEFAULT => -39
	},
	{#State 160
		DEFAULT => -86
	},
	{#State 161
		DEFAULT => -83
	},
	{#State 162
		ACTIONS => {
			'CLPAR' => 163
		}
	},
	{#State 163
		DEFAULT => -84
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
                           $m->{STATIC} = $_[1]->{STATIC};
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
#line 92 "build/Wx/XSP/XSP.yp"
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
		 'static', 1, undef
	],
	[#Rule 34
		 'static', 1, undef
	],
	[#Rule 35
		 'function', 1, undef
	],
	[#Rule 36
		 'function', 2,
sub
#line 104 "build/Wx/XSP/XSP.yp"
{ $_[2]->{STATIC} = $_[1]; $_[2] }
	],
	[#Rule 37
		 'function', 2,
sub
#line 106 "build/Wx/XSP/XSP.yp"
{ $_[2]->{PERL_NAME} = $_[1];
                      $_[2] }
	],
	[#Rule 38
		 'function', 3,
sub
#line 109 "build/Wx/XSP/XSP.yp"
{ $_[3]->{PERL_NAME} = $_[1];
                      $_[3]->{STATIC} = $_[2];
                      $_[3] }
	],
	[#Rule 39
		 '_func', 8,
sub
#line 115 "build/Wx/XSP/XSP.yp"
{ add_data_function( $_[0],
                                         name      => $_[2],
                                         ret_type  => $_[1],
                                         arguments => $_[4],
                                         class     => $class,
                                         @{ $_[7] } ) }
	],
	[#Rule 40
		 '_func', 7,
sub
#line 122 "build/Wx/XSP/XSP.yp"
{ add_data_function( $_[0],
                                         name     => $_[2],
                                         ret_type => $_[1],
                                         class     => $class,
                                         @{ $_[6] } ) }
	],
	[#Rule 41
		 'ctor', 6,
sub
#line 129 "build/Wx/XSP/XSP.yp"
{ add_data_ctor( $_[0], name      => $_[1],
                                            arguments => $_[3],
                                            class     => $class,
                                            @{ $_[5] } ) }
	],
	[#Rule 42
		 'ctor', 5,
sub
#line 134 "build/Wx/XSP/XSP.yp"
{ add_data_ctor( $_[0], name  => $_[1],
                                            class => $class,
                                            @{ $_[4] } ) }
	],
	[#Rule 43
		 'dtor', 6,
sub
#line 139 "build/Wx/XSP/XSP.yp"
{ add_data_dtor( $_[0], name  => $_[2],
                                            class => $class,
                                            @{ $_[5] },
                                      ) }
	],
	[#Rule 44
		 'metadata', 1,
sub
#line 144 "build/Wx/XSP/XSP.yp"
{ $_[1] }
	],
	[#Rule 45
		 'metadata', 2,
sub
#line 145 "build/Wx/XSP/XSP.yp"
{ [ @{$_[1]}, @{$_[2]} ] }
	],
	[#Rule 46
		 'metadata', 0,
sub
#line 146 "build/Wx/XSP/XSP.yp"
{ [] }
	],
	[#Rule 47
		 '_metadata', 1,
sub
#line 149 "build/Wx/XSP/XSP.yp"
{ $_[1] }
	],
	[#Rule 48
		 '_metadata', 1,
sub
#line 150 "build/Wx/XSP/XSP.yp"
{ $_[1] }
	],
	[#Rule 49
		 'perc_name', 4,
sub
#line 153 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 50
		 'perc_module', 4,
sub
#line 154 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 51
		 'perc_file', 4,
sub
#line 155 "build/Wx/XSP/XSP.yp"
{ $_[3] }
	],
	[#Rule 52
		 'perc_code', 2,
sub
#line 156 "build/Wx/XSP/XSP.yp"
{ [ code => $_[2] ] }
	],
	[#Rule 53
		 'perc_cleanup', 2,
sub
#line 157 "build/Wx/XSP/XSP.yp"
{ [ cleanup => $_[2] ] }
	],
	[#Rule 54
		 'type', 3,
sub
#line 159 "build/Wx/XSP/XSP.yp"
{ make_cptr( $_[0], $_[2] ) }
	],
	[#Rule 55
		 'type', 3,
sub
#line 160 "build/Wx/XSP/XSP.yp"
{ make_cref( $_[0], $_[2] ) }
	],
	[#Rule 56
		 'type', 2,
sub
#line 161 "build/Wx/XSP/XSP.yp"
{ make_ptr( $_[0], $_[1] ) }
	],
	[#Rule 57
		 'type', 2,
sub
#line 162 "build/Wx/XSP/XSP.yp"
{ make_ref( $_[0], $_[1] ) }
	],
	[#Rule 58
		 'type', 1,
sub
#line 163 "build/Wx/XSP/XSP.yp"
{ make_type( $_[0], $_[1] ) }
	],
	[#Rule 59
		 'type_name', 1, undef
	],
	[#Rule 60
		 'type_name', 1, undef
	],
	[#Rule 61
		 'type_name', 2, undef
	],
	[#Rule 62
		 'basic_type', 1, undef
	],
	[#Rule 63
		 'basic_type', 1, undef
	],
	[#Rule 64
		 'basic_type', 1, undef
	],
	[#Rule 65
		 'basic_type', 1, undef
	],
	[#Rule 66
		 'basic_type', 1, undef
	],
	[#Rule 67
		 'basic_type', 2, undef
	],
	[#Rule 68
		 'basic_type', 2, undef
	],
	[#Rule 69
		 'class_name', 1, undef
	],
	[#Rule 70
		 'class_name', 3,
sub
#line 171 "build/Wx/XSP/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 71
		 'file_name', 1,
sub
#line 173 "build/Wx/XSP/XSP.yp"
{ '-' }
	],
	[#Rule 72
		 'file_name', 3,
sub
#line 174 "build/Wx/XSP/XSP.yp"
{ $_[1] . '.' . $_[3] }
	],
	[#Rule 73
		 'file_name', 3,
sub
#line 175 "build/Wx/XSP/XSP.yp"
{ $_[1] . '/' . $_[3] }
	],
	[#Rule 74
		 'arg_list', 1,
sub
#line 177 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 75
		 'arg_list', 3,
sub
#line 178 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[3]; $_[1] }
	],
	[#Rule 76
		 'argument', 2,
sub
#line 180 "build/Wx/XSP/XSP.yp"
{ make_argument( @_ ) }
	],
	[#Rule 77
		 'argument', 4,
sub
#line 182 "build/Wx/XSP/XSP.yp"
{ make_argument( @_[0, 1, 2, 4] ) }
	],
	[#Rule 78
		 'value', 1, undef
	],
	[#Rule 79
		 'value', 2,
sub
#line 185 "build/Wx/XSP/XSP.yp"
{ '-' . $_[2] }
	],
	[#Rule 80
		 'value', 1, undef
	],
	[#Rule 81
		 'value', 1, undef
	],
	[#Rule 82
		 'value', 1, undef
	],
	[#Rule 83
		 'value', 3,
sub
#line 189 "build/Wx/XSP/XSP.yp"
{ $_[1] . '::' . $_[3] }
	],
	[#Rule 84
		 'value', 4,
sub
#line 190 "build/Wx/XSP/XSP.yp"
{ "$_[1]($_[3])" }
	],
	[#Rule 85
		 'special_blocks', 1,
sub
#line 195 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 86
		 'special_blocks', 2,
sub
#line 197 "build/Wx/XSP/XSP.yp"
{ [ @{$_[1]}, $_[2] ] }
	],
	[#Rule 87
		 'special_block', 3,
sub
#line 201 "build/Wx/XSP/XSP.yp"
{ $_[2] }
	],
	[#Rule 88
		 'special_block', 2,
sub
#line 203 "build/Wx/XSP/XSP.yp"
{ [] }
	],
	[#Rule 89
		 'special_block_start', 1,
sub
#line 206 "build/Wx/XSP/XSP.yp"
{ push_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 90
		 'special_block_end', 1,
sub
#line 208 "build/Wx/XSP/XSP.yp"
{ pop_lex_mode( $_[0], 'special' ) }
	],
	[#Rule 91
		 'lines', 1,
sub
#line 210 "build/Wx/XSP/XSP.yp"
{ [ $_[1] ] }
	],
	[#Rule 92
		 'lines', 2,
sub
#line 211 "build/Wx/XSP/XSP.yp"
{ push @{$_[1]}, $_[2]; $_[1] }
	]
],
                                  @_);
    bless($self,$class);
}

#line 213 "build/Wx/XSP/XSP.yp"


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
                 package_static => 1,
                 class_static => 1,
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
        return ( 'RAW_CODE', "$1\n" );
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
