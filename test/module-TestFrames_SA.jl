
"""
`module  JAC.TestFrames`
    ... a submodel of JAC that contains all methods for testing individual methods, modules, ....
"""
module TestFrames

    using Printf, JLD, JAC, ..AngularMomentum, ..Basics, ..Continuum, ..Defaults, ..ManyElectron, ..Nuclear, ..Radial, ..TableStrings, ..SpinAngular

    export testDummy


    function testPrint(sa::String, success::Bool)
        printTest, iostream = Defaults.getDefaults("test flag/stream")
        ok(succ) =  succ ? "[OK]" : "[Fail]"
        sb = sa * TableStrings.hBlank(110);   sb = sb[1:100] * ok(success);    println(iostream, sb)
        return( nothing )
    end


    """
    `TestFrames.testEvaluation_rcsfValues(; short::Bool=true)`
        ... tests on rcsf value.
    """
    function testEvaluation_rcsfValues(; short::Bool=true)
        success = true
        etal = 1.4928400545843579
        printTest, iostream = Defaults.getDefaults("test flag/stream")
        aT = SpinAngular.getTermNumber(3.5, 0, 4, 0)
        bT = SpinAngular.getTermNumber(3.5, 0.5, 1.5, 0)
        coeff = SpinAngular.completlyReducedCfpByIndices(aT, bT)
        if abs(coeff - etal) >  0.000000000000001
            success = false
            if printTest   info(iostream, "$coeff:   $coeff != $etal")   end
        end

        testPrint("testEvaluation_rcsfValues()::", success)
        return(success)
    end


    """
    `TestFrames.testEvaluation_angularCoefientsValues(; short::Bool=true)`
        ... tests on rcsf value.
    """
    function testEvaluation_angularCoefientsValues(; short::Bool=true)
        success = true
        etal = 1.000000000000000

        # First step: Generation of the relativistic CSFs
        configs = [Configuration("1s^2 2s"), Configuration("1s^2 2p")]
        relconfList = ConfigurationR[]
        for conf in configs
        wax = Basics.generate("configuration list: relativistic", conf)
        append!( relconfList, wax)
        end
        subshellList = Basics.generate("subshells: ordered list for relativistic configurations", relconfList)
        Defaults.setDefaults("relativistic subshell list", subshellList; printout=false)
        csfList = CsfR[]
        for relconf in relconfList
        newCsfs = Basics.generate("CSF list: from single ConfigurationR", relconf, subshellList)
        append!( csfList, newCsfs)
        end

        # Second step: Calculation of spin-angular coefficients for a none scalar one-particle operator"
        leftCsf = csfList[1]
        rightCsf1 = csfList[2]
        rightCsf2 = csfList[3]
        op = SpinAngular.OneParticleOperator(1, plus, true)
        coeff = SpinAngular.computeCoefficients(op, leftCsf, rightCsf1, subshellList)
        if abs(coeff[1].T - etal) >  0.000000000000001
            success = false
            if printTest   info(iostream, "$coeff:   $coeff != $etal")   end
        end
        coeff = SpinAngular.computeCoefficients(op, leftCsf, rightCsf2, subshellList)
        if abs(coeff[1].T - etal) >  0.000000000000001
            success = false
            if printTest   info(iostream, "$coeff:   $coeff != $etal")   end
        end

        testPrint("testEvaluation_angularCoefientsValues()::", success)
        return(success)
    end

end # module
