---
title: 'epair: An R package for acquiring EPA data easily'
tags:
  - R
  - EPA API
  - pollutant data
authors:
  - name: Geroge Leonard Orozco-Mulfinger
    orcid: TODO
    affiliation: TODO
  - name: Owais Gilani
    affiliation: Bucknell University
affiliations:
 - name: Michael Kane, Yale University
   index: 1
date: 14 August 2020
bibliography: paper.bib
---

# Summary

R users trying to get pollutant data from the EPA website can get easily discouraged. 
Needing to have a strong understanding of API’s, navigating json files, and a hefty load of 
parameter codes contribute to this sense of unease. The package, epair, waves these difficulties away. 
Built with R researchers in mind, epair makes data querying from the EPA intuitive. From options helping 
the user figure out what data they want, to actually placing the query in the EPA API, epair can do it.


# Statement of need 

`Gala` is an Astropy-affiliated Python package for galactic dynamics. Python
enables wrapping low-level languages (e.g., C) for speed without losing
flexibility or ease-of-use in the user-interface. The API for `Gala` was
designed to provide a class-based and user-friendly interface to fast (C or
Cython-optimized) implementations of common operations such as gravitational
potential and force evaluation, orbit integration, dynamical transformations,
and chaos indicators for nonlinear dynamics. `Gala` also relies heavily on and
interfaces well with the implementations of physical units and astronomical
coordinate systems in the `Astropy` package [@astropy] (`astropy.units` and
`astropy.coordinates`).

`Gala` was designed to be used by both astronomical researchers and by
students in courses on gravitational dynamics or astronomy. It has already been
used in a number of scientific publications [@Pearson:2017] and has also been
used in graduate courses on Galactic dynamics to, e.g., provide interactive
visualizations of textbook material [@Binney:2008]. The combination of speed,
design, and support for Astropy functionality in `Gala` will enable exciting
scientific explorations of forthcoming data releases from the *Gaia* mission
[@gaia] by students and experts alike.

# Citations

Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

If you want to cite a software repository URL (e.g. something on GitHub without a preferred
citation) then you can do it with the example BibTeX entry below for @fidgit.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

# Acknowledgements

We acknowledge contributions from Brigitta Sipocz, Syrtis Major, and Semyeong
Oh, and support from Kathryn Johnston during the genesis of this project.

# References
Example paper.bib file:

@article{Pearson:2017,
  	Adsnote = {Provided by the SAO/NASA Astrophysics Data System},
  	Adsurl = {http://adsabs.harvard.edu/abs/2017arXiv170304627P},
  	Archiveprefix = {arXiv},
  	Author = {{Pearson}, S. and {Price-Whelan}, A.~M. and {Johnston}, K.~V.},
  	Eprint = {1703.04627},
  	Journal = {ArXiv e-prints},
  	Keywords = {Astrophysics - Astrophysics of Galaxies},
  	Month = mar,
  	Title = {{Gaps in Globular Cluster Streams: Pal 5 and the Galactic Bar}},
  	Year = 2017
}
