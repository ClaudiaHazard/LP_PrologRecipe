ingrediente_basico("Jamon").
ingrediente_basico("Huevo").
ingrediente_basico("Harina").
ingrediente_basico("Leche").
ingrediente_basico("Azucar").
ingrediente_basico("Helado").
ingrediente_basico("Zanahoria").
ingrediente_basico("Arroz").
ingrediente_preparado("Zanahoria cocida",["Zanahoria"]).
ingrediente_preparado("Manjar",["Leche","Azucar"]).
ingrediente_preparado("Masa",["Huevo","Harina"]).
ingrediente_preparado("Panqueque",["Masa","Manjar"]).
ingrediente_preparado("Arroz especial",["Arroz","Jamon"]).
plato("Arroz con huevo",["Arroz especial","Huevo"]).
plato("Panqueque con helado",["Panqueque","Helado"]).
plato("Entrada",["Zanahoria cocida"]).
cena("Cena",["Entrada","Arroz con huevo","Panqueque con helado"]).
inmediatos(Chef,Inmediato):- member(X,Chef),ingrediente_preparado(Inmediato,[X]);
                             member(X,Chef),member(Y,Chef),ingrediente_preparado(Inmediato,[Y,X]);
			     member(X,Chef), plato(Inmediato,X);
			     member(X,Chef), member(Y,Chef),plato(Inmediato,[Y,X]);
			     permutation(Chef,P),cena(Inmediato,P).

preparar(Chef,Plato,Paso):-inmediatos(Chef,Inmediato),Plato = Inmediato,!;
                           ingrediente_preparado(Plato,M),append(_,[X|_],Chef),not(X=[]),permutation(M,P),append([X],[Paso],P),ingrediente_basico(Paso),!;
			   ingrediente_preparado(Plato,M),member(Paso,M),ingrediente_basico(Paso);
			   ingrediente_preparado(Plato,M),append(_,[X|_],Chef),not(X=[]),inmediatos(Chef,Paso),permutation(M,P),append([X],[Paso],P),ingrediente_preparado(Paso,_);
			   ingrediente_preparado(Plato,M), append(_,[X|_],Chef),not(X=[]),permutation(M,P),append([X],[N],P),ingrediente_preparado(N,_),preparar(Chef,Plato,Paso);
			   ingrediente_preparado(Plato,M),member(N,M),ingrediente_preparado(N,_),preparar(Chef,N,Paso);
			   plato(Plato,M), append(_,[X|_],Chef), not(X=[]),append([X],[Paso],M),ingrediente_basico(Paso);
			   plato(Plato,M), append(_,[X|_],Chef), not(X=[]),append([X],[N],M),ingrediente_preparado(N,_),preparar(Chef,N,Paso);
			   plato(Plato,M),member(Paso,M),ingrediente_basico(Paso);
			   plato(Plato,M),member(N,M),preparar(Chef,N,Paso);
                           cena(Plato,M),member(N,M),preparar(Chef,N,Paso).


