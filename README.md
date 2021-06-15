# Algorithm for Discrete Spherical Harmonics Expansion of 3D functions with applications in imaging
 
This is implementation of the Discrete Spherical Harmonic Expansion for 3D functions used in imaging problems. The code bases on the algorithm for Discrete Spherical Harmonic Transform (DSHT) of functions on the unit sphere [1][2]. An improved version of this code has been employed in [3] for image reconstruction in 3D Compton Scattering Tomography. 

# Pipeline

The idea consist in slicing a 3D function <img src="https://render.githubusercontent.com/render/math?math=f(x,y,z)"> in many concentric spheres of different radi and performing the DSHT for each sphere. Thus, we have radial dependent coeficients of the DSHT expansion. The full pipeline is summarized as follows: 
 
<p align="center">
  <img src="Eqs/DSHT.png" width="700" title="hover text">

</p>

where the forward inverse pairs are used for the Fourier (DFT-IDFT) and Legendre (DLT-IDLT) discrete transforms. Index j labels the radius of each sphere whereas indicesl and m lable the spherical component. Indices n and k label polar and azimuthal angles. The DFT-IDFT pair is defined in any test of signal processing, the DLT-IDLT is defined as follows: 

<p align="center">
  <img src="Eqs/eq1.png" width="500" title="hover text">

</p>

<p align="center">
  <img src="Eqs/eq2.png" width="500" title="hover text">

</p>

where P() are Legendre functions and

<p align="center">
  <img src="Eqs/eq3.png" width="500" title="hover text">

</p>

Refer to [3]  for a detailed description of the algorithm.

# Results

The DSHT-IDSHT has been applied to a 3D Shepp-Logan transform of size 64x64x64, a standard for testing algorithms in medical imaging. The figure shows representative slices of the original object and its recosntruction (column 2). Some arifacts due to Gibbs phenomenon are seen. Appropriate filtering [4] reduces this effect (column 3) and improves image quality. The 3D object is provided with the code and the main executes it automatically.

<p align="center">
  <img src="SL_SHT.png" width="900" title="hover text">

</p>

Porcentual RMSE are 0.12 % for non-filtered and 0.28 % for filtered reconstructions.

# References

[1] Driscoll J and Healy D 1994 Computing Fourier transforms and convolutions on the 2-sphere
Advances in Applied Mathematics 15 202–250

[2] Basko R, Zeng G L and Gullberg G T 1998 Application of spherical harmonics to image
reconstruction for the Compton camera Physics in Medicine and Biology 43 887–94

[3]  J. Cebeiro, C. Tarpau, M. A. Morvidone, D. Rubio and M. K. Nguyen, On a three-dimensional Compton scattering tomography system with fixed source, Inverse Problems, Special issue on Modern Challenges in Imaging, 37(2021), 054001 (23pp) , 2021. https://doi.org/10.1088/1361-6420/abf0f0 

[4] Taguchi K, Zeng G L and Gullberg G T 2001 Cone-beam image reconstruction using spherical
harmonics Physics in Medicine and Biology 46 127–138

