# An Algorithm for Discrete Spherical Harmonics Expansion of 3D images
 
This is implementation of the Discrete Spherical Harmonic Expansion for 3D functions used in imaging problems. The code uses the algorithm for Discrete Spherical Harmonic Expansion of functions on the sphere [1][2]. An improved version of this code has been used in [3] for reconstruction in 3D Compton Scattering Tomography. 

# Pipeline

The idea consist in slicing the 3D object in concentric spheres of different radi and performing the DSHT for each sphere. Thus, we have radial coeficients of the DSHT expansion. The full pipeline an be summarized as follows: 
 
<p align="center">
  <img src="Eqs/DSHT.png" width="700" title="hover text">

</p>

where the forward inverse pairs are used for the Fourier (DFT-IDFT) and Legendre (DLT-IDLT) discrete transforms. 

<p align="center">
  <img src="Eqs/eq1.png" width="500" title="hover text">

</p>

<p align="center">
  <img src="Eqs/eq2.png" width="500" title="hover text">

</p>

<p align="center">
  <img src="Eqs/eq3.png" width="500" title="hover text">

</p>

Refer to [3]  for a detailed description of the algorithm.

# Results

The DSHT-IDSHT has been applied to a 3D Shepp-Logan transform of size 64x64x64, a standard for testing algorithms in medical imaging. The figure shows some slices of the original object and its recosntruction (column 2). Some arifacts due to Gibbs phenomenon are seen. Appropriate Filtering (column 3) reduces this effect and improves image quality. The 3D object is provided with the code and the main executes it automatically.

<p align="center">
  <img src="SL_SHT.png" width="700" title="hover text">

</p>
