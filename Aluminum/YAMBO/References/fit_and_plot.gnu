c(x)=a*x**2
v(x)=b*x**2
fit [0:] c(x) 'o-01_Lifetimes.qp' u 3:4  via a
fit [:0] v(x) 'o-01_Lifetimes.qp' u 3:4  via b
set ylabel "QP widths [meV]"
set xlabel "Energy  [eV]"
p 'o-01_Lifetimes.qp' u 3:4 w p t "QP widths"
rep [0:] c(x) t "quadratic fit (conduction)"
rep [:0] v(x) t "quadratic fit (valence)"

