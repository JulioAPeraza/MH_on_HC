# MH_on_HC
Metropolis-Hastings MH algorithm to simulate the Ising model for brain connectome. 

This algorithm finds the critical temperature of the Human Connectome or any other network by inserting the connectivity matrix J.

## Prerequisites
This program requires a fast computer due to the iteration inside each Monte Carlo step.

## Description
To execute the algorithm, open [main.m](main.m). It contains three [functions](fucntions/):
* [N_critical_T.m](fucntions/N_critical_T.m): This function find numerically an estimated value of the critical temperature (TC) in order to define a range of temperature for the algorithm.
* [one_metropolis_step.m](fucntions/one_metropolis_step.m): This function correspond to one Metropolis step for flipping N spins selected randomly.
* [visualization.m](fucntions/visualization.m): This function is optional, it just visualizes the curve of Susceptibility vs Temperature.
  
## Usage
Enter the next statement in Command Window of Matlab:
```matlab
main
```
  
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

### Reference list
[Newman, E. M. J., & Barkema, G. T. (2001). "The Ising model and the Metropolis algorithm. In Monte Carlo Methods in Statistical Physics" (pp. 45–87). Oxford, UK: Oxford University Press.](https://global.oup.com/academic/product/monte-carlo-methods-in-statistical-physics-9780198517979?cc=us&lang=en&)

[Hagmann, P., Cammoun, L., Gigandet, X., Meuli, R., Honey, C. J., Wedeen, V. J., & Sporns, O. (2008). "Mapping the Structural Core of Human Cerebral Cortex". PLoS Biology, 6(7), e159.](https://doi.org/10.1371/journal.pbio.0060159)

## License
[MIT](https://choosealicense.com/licenses/mit/)
