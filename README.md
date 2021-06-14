# An Algorithm for Discrete Spherical Harmonics Expansion
 

Here, we describe succinctly our implementation of the forward-inverse Discrete Spherical Harmonics Transform (DSHT-IDSHT). The technique is based on the algorithms for the discrete Fourier and Legendre transforms as described in \cite{Basko98,Taguchi_2001,DH1994}. Let's be the discrete function $\textbf{F}_{kn}^j=F(r_j,\theta_k,\varphi_n)$ sampled with the following parameters $\Delta r=(r_{\max}-r_{\min})/(N_r-1)$ and $\Delta \varphi = 2\pi/(2N+1)$ with their corresponding indices $j= 0,...,N_r-1$ and $n=-N,...,N$. Discrete values of variables for radial and azimuthal variables are $r_j=j\Delta r + r_{\min}$ and $\varphi_n= 2\pi n/(2N+1)$. Latitude variable $\theta$ can be arbitrarily sampled in the interval $[0,\pi]$ and is labeled $\theta_k$, $k=1,...,N_\theta$, we used uniform sampling.
The relationship between the discrete function $\textbf{F}_{kn}^j$ and its representation in the domain of discrete spherical harmonics $\mathbf{F}_{lm}^j$ is summarized in the diagram:


\[
 \mathbf{F}_{nk}^j \mathrel{\mathop{\rightleftarrows}^{\mathrm{DSHT}}_{\mathrm{IDSHT}}}  \mathbf{F}_{lm}^j \,\,\,\, \,\,  :
\,\,\,\, \,\,  \left\lbrace \textbf{F}_{kn}^j \right\rbrace  \mathrel{\mathop{\rightleftarrows}^{\case{1}{N}\cdot\mathrm{DFT}}_{N\cdot\mathrm{IDFT}}} \left\lbrace  {\textbf{ F}}_{km}^j\right\rbrace   \mathrel{\mathop{\rightleftarrows}^{\mathrm{IDLT}}_{\mathrm{DLT}}} \left\lbrace \textbf{F}_{lm}^j \right\rbrace, \]

\noindent
while the first block is given by the well known discrete Fourier pairs (DFT-IDFT), the second one is given by the associated Discrete Legendre Transform pairs (DLT-IDLT)


\begin{equation}\label{eq:DLT}
\textbf{F}_{km}^j = \mathrm{DLT}^{m} \left\lbrace  \textbf{F}_{lm}^j  \right\rbrace    =     \sum_{l=|m|}^{N}  \textbf{F}_{lm}^j q_l^m P_l^m(t_k),   
\end{equation}

\noindent
and

\begin{equation}\label{eq:IDLT}
 \textbf{F}_{lm}^j = \mathrm{IDLT}^{m} \left\lbrace \textbf{F}_{km}^j \right\rbrace  =    \sum_{k=1}^{N_\theta} \textbf{F}_{km}^j q_l^m P_l^m(t_k)w_k,
\end{equation}

\noindent
where $m=-N,...,N$, $ l=|m|,...,N$, $t_k=\cos \theta_k$, $w_k$ are the Gaussian quadrature coefficients and 
\begin{equation}
\label{eq:qlm}
q_l^m= (-1)^m \sqrt{\case{2l+1}{4\pi}\case{(l-m)!}{(l+m)!}}.
\end{equation}

 
An alternative implementation can be found in \cite{DH1994}.





<p align="center">
  <img src="SL_SHT.png" width="700" title="hover text">

</p>
