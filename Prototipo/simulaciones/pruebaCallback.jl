using Plots
using DifferentialEquations

# parameters
a = 10.0
b = 28.0
c = 8/3

function lorenz!(du,u,p,t)
 a,b,c = p
 du[1] = a*(u[2]-u[1])
 du[2] = u[1]*(b-u[3]) - u[2]
 du[3] = u[1]*u[2] - c*u[3]
end

u0 = [1.0;0.0;0.0]
tspan = (0.0,100.0)
p = [a,b,c]
prob = ODEProblem(lorenz!,u0,tspan,p)

# Events
function condition(y, t, integrator)
    if t < 50.03 && t > 49.96
        a = integrator.p[1]
        println("t = $t, \t a = $a")
    end
    return t < 50
end

function affect!(integrator)
    integrator.p[1] = 2.0
end
cb = ContinuousCallback(condition, affect!)


# Solve
@time sol = solve(prob, Rodas4())
plot(sol, title = "Without callback")
savefig("without_callback")


@time sol = solve(prob, Rodas4(), callback = cb)
plot(sol, title = "With callback")
savefig("with_callback")