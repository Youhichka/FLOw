!< FLOw test.

program flow_test_primitive_compressible_add
!< FLOw test.

use flow, only : primitive_compressible
use penf, only : R_P
use vecfor, only : vector

implicit none
type(primitive_compressible) :: primitive1     !< A primitive object.
type(primitive_compressible) :: primitive2     !< A primitive object.
type(primitive_compressible) :: primitive3     !< A primitive object.
type(primitive_compressible) :: primitive4     !< A primitive object.
type(vector)                 :: velocity       !< A vector object.
logical                      :: test_passed(2) !< List of passed tests.

test_passed = .false.

velocity = 1._R_P
primitive1 = primitive_compressible(density=0.125_R_P, velocity=velocity, pressure=1._R_P)
velocity = 2._R_P
primitive2 = primitive_compressible(density=1._R_P, velocity=velocity, pressure=1._R_P)
velocity = 3._R_P
primitive3 = primitive_compressible(density=1.125_R_P, velocity=velocity, pressure=2._R_P)
primitive4 = primitive1 + primitive2
test_passed(1) = primitive3 == primitive4
print "(A,F6.3)",       'density   => 0.125  + 1   = ', primitive4%density
print "(A,3(F6.3,1X))", 'velocity  => 1      + 2   = ', primitive4%velocity
print "(A,F6.3)",       'pressure  => 1      + 1   = ', primitive4%pressure

velocity = -1._R_P
primitive1 = primitive_compressible(density=0.125_R_P, velocity=velocity, pressure=1._R_P)
primitive2 = + primitive1
test_passed(2) = primitive2 == primitive1
print "(A,F6.3)",       'density   => + (0.125) = ', primitive2%density
print "(A,3(F6.3,1X))", 'velocity  => + (-1)    = ', primitive2%velocity
print "(A,F6.3)",       'pressure  => + (1)     = ', primitive2%pressure

print "(A,L1)", new_line('a')//'Are all tests passed? ', all(test_passed)
endprogram flow_test_primitive_compressible_add
