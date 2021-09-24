
#
println("As) Test of spin-angular coefficients.")

configs = [Configuration("1s^2 3s^2"), Configuration("1s^2 3d^2")]
        
# Generate a list of relativistic configurations and determine an ordered list of subshells for these configurations
relconfList = ConfigurationR[]
for  conf in configs    wa = Basics.generate("configuration list: relativistic", conf);     append!( relconfList, wa)   end
for  i = 1:length(relconfList)    println(">> include ", relconfList[i])    end
subshellList = Basics.generate("subshells: ordered list for relativistic configurations", relconfList)
Defaults.setDefaults("relativistic subshell list", subshellList; printout=false)

# Generate the relativistic CSF's for the given subshell list
csfList = CsfR[]
for  relconf in relconfList
    newCsfs = Basics.generate("CSF list: from single ConfigurationR", relconf, subshellList);   append!( csfList, newCsfs)
end

# Calculate angular coefficients for a scalar one- or two-particle operator
op = SpinAngular.TwoParticleOperator(0, plus, true)
for  leftCsf in csfList
    for rightCsf in csfList
        coeffs = SpinAngular.computeCoefficients(op, leftCsf, rightCsf, subshellList)
        println(">> Angular coeffients for <$leftCsf || O^($(op.rank))  || $rightCsf> = \n  $coeffs")
        println("..................................................................................")
        println("")
        end
    end
