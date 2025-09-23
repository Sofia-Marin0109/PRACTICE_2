% vehiculo(Marca, Referencia, Tipo, Precio, Año).

vehiculo(toyota, corolla, sedan, 22000, 2022).
vehiculo(toyota, camry, sedan, 28000, 2023).
vehiculo(toyota, rav4, suv, 29500, 2022).
vehiculo(toyota, hilux, pickup, 36000, 2021).

vehiculo(ford, focus, sedan, 21000, 2021).
vehiculo(ford, explorer, suv, 35000, 2022).
vehiculo(ford, f150, pickup, 40000, 2023).
vehiculo(ford, mustang, sport, 45000, 2023).

vehiculo(bmw, x5, sport, 60000, 2021).
vehiculo(bmw, x6, sport, 60000, 2021).
vehiculo(bmw, m3, sedan, 70000, 2022).

vehiculo(chevrolet, silverado, pickup, 38000, 2022).
vehiculo(honda, civic, sedan, 23000, 2022).
vehiculo(honda, crv, suv, 31000, 2023).


cumple_presupuesto(Referencia, PresupuestoMax) :-
    vehiculo(_, Referencia, _, Precio, _),  
    Precio =< PresupuestoMax.

referencias_por_marca(Marca, Referencias) :-
    bagof(Ref, vehiculo(Marca, Ref, _, _, _), Referencias).

referencias_por_marca_precio(Marca, Tipo, MaxPrecio, Referencias) :-
    bagof((Ref, Tipo, Precio), (vehiculo(Marca, Ref, Tipo, Precio, _), Precio < MaxPrecio), Referencias).

referencias_por_tipo_anio(Marca, Tipo, Anio, Referencias) :-
    bagof(Ref, vehiculo(Marca, Ref, Tipo, _, Anio), Referencias).

generar_reporte(Marca,Tipo, PresupuestoGlobal, Resultado) :-
    findall((Marca, Referencia, Tipo, Precio, Anio), vehiculo(Marca, Referencia, Tipo, Precio, Anio), Lista),
     total_value(Lista, Total),
     (Total =< PresupuestoGlobal 
     -> Resultado = (Lista, Total) 
     ; Resultado = 'El total excede el límite').

total_value([], 0).
total_value([(_, _, _, Precio, _) | Rest], Total) :-
     total_value(Rest, Subtotal),
     Total is Precio + Subtotal.

test_case1(Result) :-
    findall(Ref, (vehiculo(toyota, Ref, suv, Precio,_), Precio < 30000), Result).

test_case2(Tipo, Anio, Ref) :-
    referencias_por_tipo_anio(ford, Tipo, Anio, Ref).

test_case3(Result) :-
    generar_reporte(_, sedan, 500000, Result).
