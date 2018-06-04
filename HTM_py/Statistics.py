import numpy as np
import pymc3 as pm
import theano.tensor as tt
import matplotlib.pyplot as plt
import pandas as pd

def BEST(A,B, mu_priors="Uniform", n_iter=5000, variational=False):
    '''Pretty much a copy-paste from the tutorial at
    https://docs.pymc.io/notebooks/BEST.html
    Returns traces from Markov-Chain Monte Carlo sampling applied to
    a Bayesian Estimation model for comparing the two provided group1_std
    Use "plot_posterior(trace)" to visualize the estimated posterior for:
    * Group means
    * Group standard deviations
    * Difference of means, Difference of std. deviations
    * Effect size (= diff_of_means / 0.5 * sqrt(std_1^2 + std_2^2))
    NOTE: This may take a while depending on how many samples are in your groups
    TODO: Automatically do Variational Approximation if sample size too large
    or if it looks like MCMC might not converge for whatever reason
    '''

    Y = pd.DataFrame(dict(value=np.r_[A, B],
    group=np.r_[["A"]*len(A), ["B"]*len(B)]))

    mu_m = Y.value.mean() # Mean of data for (Normal) prior on means
    mu_s = Y.value.std()
    sig_low = 0.1 # For prior on standard deviations
    sig_high = 10
    mn_low = Y.value.min() # Min, max of data for (Uniform) prior on means
    mn_hi = Y.value.max()

    with pm.Model() as model:
        print("Compiling Model")
        # Priors on means
        if mu_priors=="Uniform":
            group1_mean = pm.Uniform('group1_mean', lower=mn_low, upper=mn_hi)
            group2_mean = pm.Uniform('group2_mean', lower=mn_low, upper=mn_hi)

        elif mu_priors=="Normal":
            group1_mean = pm.Normal('group1_mean', mu=mu_m, sd=mu_s)
            group2_mean = pm.Normal('group2_mean', mu=mu_m, sd=mu_s)
        else:
            print("Currently only Uniform and Normal priors acceptable")

        # Priors for stds
        group1_std = pm.Uniform("group1_std", lower=sig_low, upper=sig_high)
        group2_std = pm.Uniform("group2_std", lower=sig_low, upper=sig_high)
        # T distribution degrees of freedom
        v1 = pm.Exponential("v_minus_one", 1/29.)+1
        v2 = pm.Exponential("v2", 1/29.)+1

        lmd_1 = group1_std ** -2
        lmd_2 = group2_std ** -2

        group1 = pm.StudentT("IEG_early", nu=v1, mu=group1_mean, lam=lmd_1,
                            observed=A)
        group2 = pm.StudentT("IEG_late", nu=v2, mu=group2_mean, lam=lmd_2,
                            observed=B)
        diff_of_means = pm.Deterministic('difference of means', group1_mean - group2_mean)
        diff_of_stds = pm.Deterministic('difference of stds', group1_std - group2_std)
        effect_size = pm.Deterministic('effect size',
                           diff_of_means / np.sqrt((group1_std**2 + group2_std**2) / 2))

        if len(Y) <= 6000 and not variational:
            print("Getting MAP Estimate")
            start = pm.find_MAP() # Start sampling at MAP estimate for better convergence
            step = pm.NUTS() # No U-Turn Sampler
            # step = pm.Metropolis()

            print("Sampling :)")
            trace = pm.sample(n_iter, start=start, step=step, cores=8, tune=2000)
            trace_burned = trace[500:]
        else:
            print("Using Variational Approximation")
            step = pm.ADVI()
            print("Optimizing")
            trace_burned = step.fit()

        print("Done!")
        ppc = pm.sample_ppc(trace_burned, samples=1000, model=model)
    return trace_burned, ppc


def posterior_plots(trace, n_samples=1000, *args, **kwargs):
    if hasattr(trace, "get_optimization_replacements"):
        trace = trace.sample(n_samples)
        print("Sampling from variational posterior...")
    pm.plot_posterior(trace, color='#87ceeb',*args, **kwargs)
