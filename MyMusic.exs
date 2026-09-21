defmodule MyMusic do

  def iniciar do
    canciones = [
      %{
        id: 1,
        titulo: "Spring Day",
        artista: "BTS",
        genero: "K-pop",
        duracion: 274,
        favorita: true
      },
      %{
        id: 2,
        titulo: "Break Stuff",
        artista: "Limp Bizkit",
        genero: "Nu Metal",
        duracion: 246,
        favorita: false
      },
      %{
        id: 3,
        titulo: "Chop Suey!",
        artista: "System of a Down",
        genero: "Nu Metal",
        duracion: 330,
        favorita: false
      }
    ]

    playlists = [
      %{
        id: 1,
        nombre: "Para Entrenar",
        descripcion: "Canciones para escuchar mientras entreno",
        canciones: [2, 3]
      },
      %{
        id: 2,
        nombre: "Favoritas",
        descripcion: "Mis canciones favoritas",
        canciones: [1]
      }
    ]

    menu(canciones, playlists)
  end

  def menu_canciones(canciones) do

    Util.mostrar_mensaje("""

    ==============================
              CANCIONES
    ==============================
    1. Crear canción
    2. Ver canciones
    3. Actualizar canción
    4. Eliminar canción
    5. Buscar canción
    6. Volver

    """)

    opcion = Util.ingresar("Seleccione una opción: ", :entero)

    case opcion do
      1 ->
        nuevas_canciones = crear_cancion(canciones)
        menu_canciones(nuevas_canciones)

      2 ->
        mostrar_canciones(canciones)
        menu_canciones(canciones)

      3 ->
        nuevas_canciones = actualizar_cancion(canciones)
        menu_canciones(nuevas_canciones)

      4 ->
        nuevas_canciones = eliminar_cancion(canciones)
        menu_canciones(nuevas_canciones)

      5 ->
        buscar_cancion(canciones)
        menu_canciones(canciones)

      6 ->
        canciones

      _ ->
        Util.mostrar_mensaje("Opción inválida.")
        menu_canciones(canciones)
  defp menu(canciones, playlists) do

    """
    ========================================
                  MyMusic
    ========================================
    1. Gestionar canciones
    2. Gestionar playlists
    3. Agregar canción a una playlist
    4. Eliminar canción de una playlist
    5. Ver estadísticas
    6. Salir
    """
    |>Util.mostrar_mensaje()

    opcion = "Seleccione una opción: "
    |> Util.ingresar(:entero)

    case opcion do
      1 ->
        menu_canciones(canciones, playlists)
      2 ->
        menu_playlists(canciones, playlists)
      3 ->
        {nuevas_playlists, msg} = agregar_a_playlist(canciones, playlists)
        Util.mostrar_mensaje(msg)
        menu(canciones, nuevas_playlists)
      4 ->
        {nuevas_playlists, msg} = quitar_de_playlist(playlists)
        Util.mostrar_mensaje(msg)
        menu(canciones, nuevas_playlists)
      5 ->
        ver_estadisticas(canciones, playlists)
        menu(canciones, playlists)
      6 ->
        Util.mostrar_mensaje("¡Gracias por usar MyMusic!")
      _ ->
        Util.mostrar_mensaje("Opción inválida.")
        menu(canciones, playlists)
    end
  end

end

MyMusic.iniciar()
