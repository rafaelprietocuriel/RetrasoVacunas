# RetrasoVacunas
Projecto para calcular el retraso entre recepción y aplicación de vacunas.

Recibe un csv que contiene, para cada día, el número de vacunas que se reciben y se aplican en México. 
El modelo asume que no hay mermas (reportadas en menos de 42,000) y considera un sistema "first in first out", FIFO, para el reporte diario. Nota que el sistema FIFO puede alterar el retraso que existe para un solo día. Si por ejemplo, mañana se aplican solo las vacunas que llegaron hoy, entonces el retraso de mañana será de cero, pero el remanente de vacunas o el inventario existente tiene un retraso de +1 por esa decisión. Por ello, aunque FIFO cambia el número puntual de cada día, no cambia el promedio ni el largo plazo.

Otro ángulo es hacer el cálculo del número total de días - vacuna que llevamos y dividir entre el número de vacunas aplicadas. Aunque ese cálculo está sobreestimado (pues hay días vacuna cumplidos por vacunas no aplicadas aún) con grandes números, ese cálculo converge al estimado.
