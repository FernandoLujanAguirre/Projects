using LinearAlgebra
using PlotlyJS

# Parámetros
N = 200
δ_vals = range(-2*pi, 2*pi; length=N)
hr_vals = range(-1.0, 1.0; length=N)

# Matriz para almacenar rango del jacobiano
rank_map = zeros(Float64, N, N)

for i in 1:N, j in 1:N
    δ = δ_vals[i]
    h_r = hr_vals[j]

    # Jacobiano en el punto
    Jh = [
        -h_r * sin(δ)  cos(δ);
         h_r * cos(δ)  sin(δ);
         0.0           0.0
    ]

    # Calcular rango numérico con tolerancia
    r = rank(Jh; atol=1e-6)
    rank_map[i, j] = r
end

# Crear heatmap con PlotlyJS
heatmap_trace = heatmap(
    x=δ_vals,
    y=hr_vals,
    z=rank_map',
    colorscale="Viridis",
    colorbar=attr(title="Rank"),
    reversescale=false
)

layout = Layout(
    title="Mapa de rango del Jacobiano - Singularidades",
    xaxis=attr(title="δ (ángulo de gimbal)"),
    yaxis=attr(title="h_r (momento angular rotor)"),
    width=700,
    height=500
)

plot(heatmap_trace, layout)
