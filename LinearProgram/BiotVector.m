% B = BiotVector(mu,r) is simply a function that solves the Biot Savart law
% for the magnetic field a distance [rx ry rz] from a dipole [mux muy muz].

function  B = BiotVector(mu,r)
B = 10E-7*((3*dot(mu,r)*r)/norm(r,2)^5 - mu/norm(r,2)^3);
end

