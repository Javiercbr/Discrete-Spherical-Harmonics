# Algorithm for Discrete Spherical Harmonic Expansion of 3D functions
 
This is an implementation of the Discrete Spherical Harmonic Expansion for 3D functions useful for some 3D inverse problems in imaging. The code bases on the algorithm for Discrete Spherical Harmonic Transform (DSHT) of functions on the unit sphere [1][2]. An improved version of this code has been employed for image reconstruction in 3D Compton Scattering Tomography [3]. The algorithm was developed in 2019 during a visit to the Laboratory ETIS (Equipes Traitement de l'Information et Systèmes CYU Cergy Paris University/ENSEA). 


# Circular Component Expansion in 2D

This is the 2D relative of the Spherical Harmonic Expansion in 3D. A function in  <img src="https://render.githubusercontent.com/render/math?math=\mathbb{R}^2">  written in polar coordinates as <img src="https://render.githubusercontent.com/render/math?math=F(r,\phi )"> is decomposed in circular components. The function on a circle of radius r centered at the origin are then expanded as Fourier series of a <img src="https://render.githubusercontent.com/render/math?math={2\pi}">-periodic function according


<img src="https://render.githubusercontent.com/render/math?math=F(r, \phi)=\sum_{l\in \mathbb{Z}}F_{l}(r)e^{il\phi},">
where

<img src="https://render.githubusercontent.com/render/math?math=F_{l}(r)= \frac{1}{2\pi}\int_0^{2\pi} d\phi \, F(r,\phi)e^{-i l\phi}.">

The discrete expansion can easily be carried out using the DFT-IDFT pair and the efficient FFT algorithm.

# Spherical Harmonic Expansion in 3D

The idea consists in slicing a function
 <img src="https://render.githubusercontent.com/render/math?math=f: \mathbb{R}^3 \rightarrow \mathbb{R}"> in spheres centered at the origin. In spherical coordinates, the function is <img src="https://render.githubusercontent.com/render/math?math=F(r,\theta,\phi )">. For a given radius <img src="https://render.githubusercontent.com/render/math?math=r">, the values of the function lie on a sphere parametrized by angles <img src="https://render.githubusercontent.com/render/math?math=(\theta,\phi )\in\[0, \pi]\times[0, 2\pi)">. Functions on a sphere of radius <img src="https://render.githubusercontent.com/render/math?math=r"> can be expanded using Spherical Harmonic Expansion according


<img src="https://render.githubusercontent.com/render/math?math=F(r,\theta,\phi)=\sum_{l=0}^\infty\sum_{|m|\leq l}F_{lm}(r)Y_l^m(\theta,\phi),">

where the Spherical Harmonics are

<img src="https://render.githubusercontent.com/render/math?math=Y_l^m(\theta,\phi)=(-1)^m\sqrt{\frac{(2l %2B 1)(l-m)!}{4\pi(l %2B m)!}}P^m_l(\cos\theta)e^{im\phi},">

and the radial components are

<img src="https://render.githubusercontent.com/render/math?math=F_{lm}(r)=\langle F, Y_l^m \rangle=\int_0^{2\pi}\int_0^\pi F(r,\theta,\phi)\overline{Y_l^m(\theta,\phi)}\sin\theta \,d\theta d\phi,">


 where the overline denotes complex conjugation.
 

# Algorithm: Discrete Spherical Harmonic Expansion

 In the discrete case, the samples of function <img src="https://render.githubusercontent.com/render/math?math=F_{kn}^j = F(r_j,\theta_k,\phi_n )"> are decomposed to obtain the radial dependent coefficients of the DSHT expansion <img src="https://render.githubusercontent.com/render/math?math=(F^j_{lm}=F_{lm}(r_j))">. The IDSHT allows to recover the original function, the full pipeline is summarized as follows: 
 
<p align="center">
  <img src="Eqs/DSHT.png" width="700" title="hover text">

</p>

where the forward-inverse pairs are used for the Discrete Fourier Transform (DFT-IDFT) and the Discrete Legendre Transform (DLT-IDLT). Index <img src="https://render.githubusercontent.com/render/math?math=j"> labels the radius of each sphere whereas indices <img src="https://render.githubusercontent.com/render/math?math=l"> and <img src="https://render.githubusercontent.com/render/math?math=m"> label the spherical component. Indices <img src="https://render.githubusercontent.com/render/math?math=n=-N,...,N"> and <img src="https://render.githubusercontent.com/render/math?math=k=1,...,N_\theta"> label the polar <img src="https://render.githubusercontent.com/render/math?math=\phi \in [0, 2\pi)"> and azimuthal angles <img src="https://render.githubusercontent.com/render/math?math=\theta\in\[0, \pi]">. Radius <img src="https://render.githubusercontent.com/render/math?math=r"> must cover the support of the function.

The algorithm employs the standard definition for the DFT-IDFT pair. The DLT-IDLT is defined as follows: 

<p align="center">
  <img src="Eqs/eq1.png" width="500" title="hover text">

</p>

<p align="center">
  <img src="Eqs/eq2.png" width="500" title="hover text">

</p>

where <img src="https://render.githubusercontent.com/render/math?math=N"> is the order of the expansion, <img src="https://render.githubusercontent.com/render/math?math=N_\theta"> the discretization in the azimuthal angle,  <img src="https://render.githubusercontent.com/render/math?math=P_l^m(t_k)"> are Legendre polynomials of degree <img src="https://render.githubusercontent.com/render/math?math=l=0,...,N"> and order <img src="https://render.githubusercontent.com/render/math?math=m=-N,...,N">, <img src="https://render.githubusercontent.com/render/math?math=t_k=\cos \theta_k">, <img src="https://render.githubusercontent.com/render/math?math=w_k"> is the Gaussian quadrature factor (calculated with a third party script), and

<p align="center">
  <img src="Eqs/eq3.png" width="500" title="hover text">

</p>

Refer to [3] for a more detailed description of the algorithm.

# Numerical reconstruction

The DSHT-IDSHT of order <img src="https://render.githubusercontent.com/render/math?math=N=256"> has been applied to a 3D Shepp-Logan phantom of size 64x64x64. This is a 3D version of the benchmark for testing algorithms in medical imaging. The figure shows six representative slices of the original object (column 1) and its reconstruction (column 2). The reconstruction exhibits some artifacts due to Gibbs phenomenon. Appropriate filtering [4] reduces this effect (column 3) and improves image quality. The 3D object is provided with the code and the main executes it automatically.

<p align="center">
  <img src="SL_SHT.png" width="900" title="hover text">

</p>

Percent RMSE (root mean squared error) is 0.12% for non-filtered and 0.28% for filtered reconstructions.

# References

[1] Driscoll J and Healy D 1994 Computing Fourier transforms and convolutions on the 2-sphere
Advances in Applied Mathematics 15 202–250

[2] Basko R, Zeng G L and Gullberg G T 1998 Application of spherical harmonics to image
reconstruction for the Compton camera Physics in Medicine and Biology 43 887–94

[3]  J. Cebeiro, C. Tarpau, M. A. Morvidone, D. Rubio and M. K. Nguyen, On a three-dimensional Compton scattering tomography system with fixed source, Inverse Problems, Special issue on Modern Challenges in Imaging, 37(2021), 054001 (23pp) , 2021. https://doi.org/10.1088/1361-6420/abf0f0 

[4] Taguchi K, Zeng G L and Gullberg G T 2001 Cone-beam image reconstruction using spherical
harmonics Physics in Medicine and Biology 46 127–138

