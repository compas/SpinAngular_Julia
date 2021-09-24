using Test
using JAC, ..Defaults, ..TestFrames

@testset "Name" begin
    ##x global short = true
    printstyled("\nPerform tests on the JAC program; this may take a while .... \n", color=:cyan)
    ## Defaults.Constants.define("print test: open", pwd() * "/runtests.report")

    ##x include("inc-halfintegers.jl")
    ##x include("inc-wignersymbols.jl")
    ##x include("inc-racahsum.jl")

    ##x redirect_stdout(streamDummy) do
    @testset "JAC methods" begin
        @test TestFrames.testEvaluation_rcsfValues() 
        @test TestFrames.testEvaluation_angularCoefientsValues() 
    end


    ## Defaults.setDefaults("print test: close", "")
end
