defmodule FiltrarPeliculas do
  def main do
    categoria = "Ingrese la categoría a filtrar "
    |> ingresar_categoria()
    puntuación_minima = "Ingrese la puntuación mínima a filtrar(0-100): "
    |> ingresar_puntuacion()
    puntuación_maxima = "Ingrese la puntuación máxima a filtrar(0-100): "
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

  def ingresar_categoria(mensaje) do
    categoria = mensaje <> "Las categorías son las siguientes" <> "(#{Enum.join(obtener_categorias(), ", ")}): "
    |> Util.ingresar(:texto)
    |> String.trim()
    if  not Enum.member?(obtener_categorias(), categoria) do
      Util.mostrar_error("Error: La categoría ingresada no es válida.")
      ingresar_categoria(mensaje)
    else
      categoria
    end
  end

  def obtener_categorias do
    peliculas()
    |> Enum.map(& &1[:categoria])
    |> Enum.uniq()
  end

  def filtrar_peliculas(categoria,puntuación_minima,puntuación_maxima)do
    Enum.filter(peliculas(), fn pelicula ->
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

  def peliculas do
    [
      %{titulo: "Inception", categoria: "Ciencia Ficción", puntuación: 87},
      %{titulo: "The Dark Knight", categoria: "Acción", puntuación: 94},
      %{titulo: "Interstellar", categoria: "Ciencia Ficción", puntuación: 91},
      %{titulo: "Pulp Fiction", categoria: "Crimen", puntuación: 89},
      %{titulo: "The Shawshank Redemption", categoria: "Drama", puntuación: 93},
      %{titulo: "The Godfather", categoria: "Crimen", puntuación: 92},
      %{titulo: "The Matrix", categoria: "Ciencia Ficción", puntuación: 88},
      %{titulo: "Forrest Gump", categoria: "Drama", puntuación: 90},
      %{titulo: "Gladiator", categoria: "Acción", puntuación: 85},
      %{titulo: "The Avengers", categoria: "Acción", puntuación: 83}
    ]
  end
end

FiltrarPeliculas.main()
