#############################################################################################
# The Ornstein–Uhlenbeck process is a stochastic process with applications in 
# financial mathematics and the physical sciences. Its original application in 
# physics was as a model for the velocity of a massive Brownian particle under 
# the influence of friction. It is named after Leonard Ornstein and George Eugene Uhlenbeck.
#
## Here we are solving the following Stochastic Differential Equation :
#
#                dx_t = theta*(mu - x_t) + sigma*dW_t
#
#############################################################################################

using Random, Plots


## Parameters SDE

theta = 0.7
mu = 1.5
sigma = 0.5



## Parameters Simulation

nb_simu = 10 # number of simulations
t_init = 3
t_end = 7
N = 1000 # Number of grid points
dt = (t_end-t_init)/N
t = t_init:dt:t_end
x_init = 0 # initial value of x
rng = MersenneTwister(1) # random seed



## Simulation function

function run_simulation()
    xs = zeros(N+1)
    xs[1] = x_init
    for i in 1:N
        x = xs[i]
        xs[i+1] = x + (theta*(mu-x))*dt + sigma*(rand(rng , 1)[1]*sqrt(dt))
    end
    # Add simulation to plot
    return xs
end




## Running all the simulations
mean = zeros(N+1) # mean of all the simulations
for simu in 1:nb_simu
    result = run_simulation()

    global mean = mean+result

    plot!(t,result,label=false) # plot the result of simulation in the same plot
      
end

mean = (1/nb_simu)*mean
plot!(t,mean,label="mean",color="red",legend=:outerright,lw=2) # plot mean in red with line_width=2
xlabel!("t")
title!("Ornstain Uhlenbeck Process Simulation")

# Save plot as image
savefig("Ornstain-Uhlenbeck-Process_Plot.png")


