defmodule FiltrarPelicuas do
  def main do
    categoria = "Ingrese la categoría a filtrar: "
    |> Util.ingresar(:texto)
    puntuación_minima = "Ingrese la puntuación mínima a filtrar: "
    |> ingresar_puntuacion()
    puntuación_maxima = "Ingrese la puntuación máxima a filtrar: "
    |> ingresar_puntuacion()
    filtrar_peliculas(categoria, puntuación_minima, puntuación_maxima)
    |> generar_mensaje()
    |> Util.mostrar_mensaje()
  end

  def ingresar_puntuacion(mensaje) do
    puntuación = mensaje
    |> Util.ingresar(:entero)
    if puntuación < 0 or puntuación > 100 do
      Util.mostrar_error("Error: La puntuación debe estar entre 0 y 100.")
      ingresar_puntuacion(mensaje)
    else
      puntuación
    end
  end

  def filtrar_peliculas(categoria,puntuación_minima,puntuación_maxima)do
    peliculas = [
      %{titulo: "El Padrino", categoria: "Drama", puntuación: 98},
      %{titulo: "Pulp Fiction", categoria: "Crimen", puntuación: 94},
      %{titulo: "Forrest Gump", categoria: "Drama", puntuación: 89},
      %{titulo: "Inception", categoria: "Ciencia Ficción", puntuación: 87},
      %{titulo: "La La Land", categoria: "Musical", puntuación: 85},
      %{titulo: "El Rey León", categoria: "Animación", puntuación: 92},
      %{titulo: "Gladiador", categoria: "Acción", puntuación: 88},
      %{titulo: "Titanic", categoria: "Romance", puntuación: 90},
      %{titulo: "Matrix", categoria: "Ciencia Ficción", puntuación: 93},
      %{titulo: "Toy Story", categoria: "Animación", puntuación: 91},
      %{titulo: "El Señor de los Anillos", categoria: "Fantasía", puntuación: 97},
      %{titulo: "Joker", categoria: "Drama", puntuación: 86},
      %{titulo: "Avengers: Endgame", categoria: "Acción", puntuación: 84},
      %{titulo: "Coco", categoria: "Animación", puntuación: 88},
      %{titulo: "Amélie", categoria: "Comedia", puntuación: 83}
    ]
    Enum.filter(peliculas, fn pelicula ->
      pelicula[:categoria] == categoria and
      pelicula[:puntuación] >= puntuación_minima and
      pelicula[:puntuación] <= puntuación_maxima
    end)
  end

  def generar_mensaje([]) do
    "No se encontraron películas que coincidan con los criterios de búsqueda."
  end

  def generar_mensaje(peliculas) do
    "Se encontraron las siguientes películas:\n" <>
    Enum.map_join(peliculas, "\n", fn pelicula ->
      "#{pelicula[:titulo]} (#{pelicula[:categoria]}): #{pelicula[:puntuación]}"
    end)
  end
end

FiltrarPelicuas.main()
