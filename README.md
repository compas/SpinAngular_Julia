# SpinAngular

```
=======================================================================

     Angular coefficients for symmetry-adopted configuration states in jj-coupling


     Gediminas Gaigalas
     Institute of Theoretical Physics and Astronomy,
     Vilnius University, Sauletekio Ave. 3, LT-10222 Vilnius,
     Lithuania

     e-mail: gediminas.gaigalas@tfai.vu.lt

=======================================================================

The "SpinAngular" module is designed as a part of the JAC package for the computation
of spin-angular integration in atomic theory.

The spin-angular approach of G. Gaigalas, Z. Rudzikas and C. Froese Fischer,
J. Phys. B: At. Mol. Opt. Phys. 30 (1997) 3747 is implemented for (tensorial coupled)
one-particle operators of arbitrary rank, scalar two-particle operators as well as
for the manipulation of reduced matrix elements from this theory.


The methods used in the program are based on the accurate four-component one-electron
radial wave functions which were calculated including correlation and relativistic
effects. The program calculates the matrix elements of crystal field operator and
diagonalizes matrix of full atomic Hamiltonian (including matrix elements between
different atomic state functions).


===========================
INSTALLATION OF THE PROGRAM
===========================

The installation procedure assumes that the newest JAC package has already been installed.
The program will be incorporated automatically. It means the files
module-SpinAngular-inc-reducedcoeffs.jl,  module-SpinAngular.jl will be in the directory:
"/home/user/.julia/packages/JAC/Version_Of_JAC" with the up-to-date version "Version_Of_JAC" of JAC.
For further installation you need to take the following steps:

1. Copy the file SpinAngular_Program.tgz to the main directory /home/user/.julia/packages/.

2. Untar it by typing

   >> tar -zxvf SpinAngular_Program.tgz

   A directory SpinAngular_Program will appear.

3. Copy the jac.jl by typing
   >> cp jac.jl /home/user/.julia/packages/JAC/Version_Of_JAC/src


===========================
TESTING OF INSTALLATION
===========================

1. Go to the source directory of JAC
/home/user/.julia/packages/JAC/Version_Of_JAC/src

2. Type the following commands:

> cp module-TestFrames.jl module-TestFrames_ORG.jl
> cp /home/user/.julia/packages/srcSpinAngular_Program/test/module-TestFrames_SA.jl module-TestFrames.jl

3. Run the following command:

julia> include("runtestsSA.jl")

in the environment of julia from the directory  /home/gaigalas/.julia/packages/SpinAngular_Program/test

Self-testing of the program starts. In case the testing is successful, the following message will appear:
julia> include("runtestsSA.jl")

Perform tests on the JAC program; this may take a while ....
testEvaluation_rcsfValues()::                                                                       [OK]
testEvaluation_angularCoefientsValues()::                                                           [OK]
Test Summary: | Pass  Total
Name          |    2      2
Test.DefaultTestSet("Name", Any[Test.DefaultTestSet("JAC methods", Any[], 2, false)], 0, false)

4. Return to the original module-TestFrames.jl file by typing the following:

> cp /home/user/.julia/packages/JAC/Version_Of_JAC/src/module-TestFrames_ORG.jl /home/user/.julia/packages/JAC/Version_Of_JAC/src/module-TestFrames.jl

========================
EXECUTION OF THE PROGRAM
========================

If julia environment starts from the directory "work" then the package is downloaded with the following command:
julia> include("../r3byw/src/jac.jl")

Execution of the program is the same as that for JAC.
The selected functions of the "SpinAngular" module are as follows:
i) General purpose functions for quasispin representation:

"SpinAngular.getTermNumber()":  Returns the internal index for a subshell term that is specified by its angular
                                momentum $j$, the quasispin quantum number $Q$ as well as the total subshell
                                angular momentum $J$.
"SpinAngular.qspaceTerms()":    Returns a list of quasi-spin ($Q$-space) terms for the given state number.
"SpinAngular.qshellTermM()":    Computes the $M_Q$ quantum number of a subshell term.
"SpinAngular.qshellTermQ()":    Computes the $Q$ quantum number of a subshell term.

ii) Functions for computing completely reduced matrix elements in $Q$- and $J$-spaces:
"SpinAngular.completelyReducedCfpByIndice()": Returns for two given subshell terms the (completely) reduced
                                              coefficient of fractional parentage
                                              (j \alpha Q J||| a^{(q j)}|||j \alpha' Q' J').
"SpinAngular.completelyReducedWkk()":         Returns for two given subshell terms the (completely) reduced matrix elements
                                              (j \alpha Q J||| W^{(k_q k_j)}||| j \alpha' Q' J')

iii) Functions for computing the reduced matrix elements in $J$-spaces:
SpinAngular.irreducibleTensor()":     Computes the reduced matrix elements from
                                      Eqs.~(7)-(11); the distinction between the individual matrix elements is made by
                                      multiple dispatch and proper types of parameters.

iv) Functions for computing the recoupling matrices for given subshell states with any number of open subshells:
"SpinAngular.recoupling1p()":  Computes various recoupling matrices for a (non-) scalar one-particle operator,
                               including R(j_a, \Lambda^{bra}, \Lambda^{ket}) for one interacting subshell [cf. Ref. [4], Eq. (14)]
                               or R(j_a, j_b, \Lambda^{bra}, \Lambda^{ket}) for two interacting subshells  [cf. Ref. [4], Eq. (19)].
                               The distinction is made by multiple dispatch and proper types of arguments.
"SpinAngular.recoupling2p()":  Computes the recoupling matrices for a scalar two-particle operator, including
                               R(j_a, j_b, \Lambda^{bra}, \Lambda^{ket}) for two interacting subshells [cf. Ref. [4], Eq. (22)],
                               R(j_a, j_b, j_c, \Lambda^{bra}, \Lambda^{ket}) for three interacting subshells [cf. Ref. [4], Eq. (26)] or
                               R(j_a, j_b, j_c, j_d, \Lambda^{bra}, \Lambda^{ket}) for four interacting subshells [cf. Ref. [4], Eq. (33)],
                               respectively. Again, the distinction is made by multiple dispatch and proper types of arguments.

v) Functions for computing the spin-angular coefficients for two CSF with any number of open subshells:
SpinAngular.computeCoefficients()":  Computes the spin-angular coefficients for scalar and non-scalar
                                     one-particle operators of any rank as well as for scalar two-particle operators.

Further details about the purpose, input parameters and the return values of these functions can be obtained at the Julia "Repl" by typing, for instance,
"?~SpinAngular.recoupling1p}."


=====================
THE PROGRAM STRUCTURE
=====================

The program is written in the programming language julia.
It uses JAC package.

The Selected data structures of the "SpinAngular" module are relevant for computations of angular
coefficients, matrix elements of unit tensors and other entities from the isospin formalism. The detailed definition of
these data structures, including their purpose and subfields, can be obtained at the Julia "Repl" by typing,
for instance, "?~Coefficient1p".

Data structure                   Brief explanation

"AbstractAngularType"            Defines an abstract type for dealing with symmetric many-electron operators of different rank;
                                 it comprises the two subtypes "OneParticleOperator" and "TwoParticleOperator".

"Coefficient1p"                  Data structure to deal with and keep one-particle angular coefficients, including the
                                 specification of the orbitals, the rank of the reduced one-particle interaction strength and
                                 the value of the coefficient.

"Coefficient2p"                  Analogue as above but for the coefficients of two-particle operators.

"QspaceTerm"                     Specifies a subshell term |j (\nu)\, \alpha\, QJ> or |j (\nu)\, \alpha\, Q J,\, N_r>
                                 for a subshell with well-defined $j$.

SchemeEta_W                      A (singleton) data structure to distinguish between different internal coupling schemes;
                                 other data structures of this sort are
                                 "SchemeEta_WW", "SchemeEta_Wa", "SchemeEta_a", "SchemeEta_aW".

===========
MIT LICENSE
===========
```
