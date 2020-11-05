# ARAMiS
The code **ARAMiS** (**A**coustic **R**esponse of **A**nisotropic **M**ult**i**layered **S**tructures) is a tool to calculate the transmission loss, reflection coefficient, or absorption coefficient of any given structure multilayered structure.

The purpose of the project was to study the influence of the instrinsic anisotropy of poroelastic media on the wave propagation within multilayered structures. 

The code has been written in Matlab, and compiles in both Matlab and Octave.

This code has been created as an outcome of the Ph.D. thesis entitled *On multilayered system dynamics and waves in anisotropic poroelastic media* by Juan Parra. The doctoral project was done as an international *cotutelle* agreement between KTH Royal Institute of Technology (Stockholm, Sweden), and Le Mans Université (Le Mans, France).

All terminology used in the code refers to [the bibliography](Bibliography).

## Conditions of usage
The use of this software is permitted under the license LGPL-3.0.
A particular request from the author is that you cite the relevant publications in [the bibliography](Bibliography) if you use the code.
The author may be contacted at [jppm@kth.se](mailto:jppm@kth.se).

## How to

The code relies on the Transfer Matrix Method (TMM). All physical fields are assumed to be a superposition of hamonic plane waves.

The numerical method, physical and material models can be found in [the bibliography](Bibliography).

### Structure of the code
The code has 3 structures:
* `in` - denotes the inputs
* `L` - denotes the material layers
* `out` - denotes the output. Note that after the calculations, several fields in the structures **L** are added.

For the code to compute, you need to define:
* All the elements of the structure `in` as explained in the following.
* `L.d`, `L.material.type` and `L.material.sheet` for each layer. 

#### `in` - input
* `in.f` denotes a vector with frequencies (in Hz),
* `in.theta_1` and `in.theta_2` denote the angles (in radians) of incidence of the plane waves. See the bibliography for details on these angles. Avoid setting the angles to 0, as numerical instabilities may occur,
* `in.termination` denotes the termination of the problem. Set to `'tranmission'` if you are interested in the transmission problem, *i.e.* the last layer if coupled to a semi-infinite fluid on the wave propagation direction. Set to `'rigid backing'` if you are interested in the absorption problem, *i.e.* the last layer in coupled to a rigid backing.
	
#### `L` - material layers
For a layer `i=1...N`:
* `L(i).d` denotes the thickness (in m),
* `L(i).material.type` denotes the material type, *i.e.* `'fluid'`, `'solid'` or `'pem'` (poroelastic media),
* `L(i).material.sheet` denotes the material properties as stated in the database, located in `'/src/Materials'`. To define your own material, follow the principle of the material sheets in the repository.
	
The previous elements of the structure `L` need to be defined before any calculation is possible.
After the computation, several elements will appear in the structure L.  Several of them involve the computation of the solution. However the following correspond to physical fields/phenomena:

* `L(i).Alpha` is the state matrix as defined in the bibliography.
*  `L(i).statevector` contains the physical field variables in the state vector, as defined in the bibliography
*  `L(i).wave` contains the elements:
	* `q`, which denotes the wave amplitudes, 
	* `attenuation`, which denote the wave attenuations,
	* `length`, which denote the wavelengths,
	* `num`, which denote the wavenumbers,
	* `pol`, which denote the wave polarisations,
	* `slowness`, which denote the wave slowness.
	The dimensions of the elements of `L(i).wave` are (M,f), where `M` is the number of waves in the medium, and `f` is the number of frequencies.
* `L(i).disspow` contains the powers (in W/m2) dissipated by the different phenomena: `struct`, `th`, `vis` and `tot`, which are respectively the dissipated power by structural means, by thermal means, by viscous means, as well as the total dissipated power.
* `L(i).kinpow` and `L(i).kinen` contains the powers (in W/m2) and energies in the layer.

#### `out` - output

* if `in.termination='transmission'`, then `out.TL` denotes the sound transmission loss of the multilayered structure (in dB) per frequency (as defined in `in.f`).
* if `in.termination='rigid backing'`, then `out.R` denotes the reflection coefficient (real and imaginary parts) of the multilayered structure per frequency (as defined in `in.f`); `out.Absoprt` denotes the absorption coefficient of the multilayered structure per frequency (as defined in `in.f`).
	
# Acknowlegments
The following people contributed in no small matter to the development of the code ARAMiS. Their contribution is highly acknowledged.

* Prof. Peter Göransson, KTH Royal Institute of Technology, Stockholm, Sweden
* Prof. Olivier Dazel, Le Mans Université, Le Mans, France
* Jacques Cuenca, Siemens Industry Software, Leuven, Belgium / KTH Royal Institute of Technology, Stockholm, Sweden
* Luca Manzari, KTH Royal Institute of Technology, Stockholm, Sweden
	
# Bibliography
Parra, J. (2016). Acoustic analysis of anisotropic poroelastic multilayered systems. Journal of Applied Physics, 119(8), 84907. https://doi.org/10.1063/1.4942443

Parra, J. (2016). Derivation of the state matrix for dynamic analysis of linear homogeneous media. The Journal of the Acoustical Society of America, 140(2), EL218–EL220. https://doi.org/10.1121/1.4960624

Parra, J. (2016). On multilayered system dynamics and waves in anisotropic poroelastic media [KTH Royal Institute of Technology & Le Mans Université]. ISSN 1651-7660.
