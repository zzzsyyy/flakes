(final: prev:

let
  libjxl-with-plugins = final.callPackage ../pkgs/libjxl-with-plugins { };
in

{
  # libjxl-with-plugins = final.callPackage ../pkgs/libjxl-with-plugins { };
  # })
  # (final: prev: {
  gnome = prev.gnome.overrideScope'
    (final': prev': {
      nautilus = prev'.nautilus.overrideAttrs (old: {
        preFixup = with prev; ''
          gappsWrapperArgs+=(
            # Thumbnailers
            --prefix XDG_DATA_DIRS : "${gdk-pixbuf}/share"
            --prefix XDG_DATA_DIRS : "${librsvg}/share"
            --prefix XDG_DATA_DIRS : "${webp-pixbuf-loader}/share"
            --prefix XDG_DATA_DIRS : "${shared-mime-info}/share"
            --prefix XDG_DATA_DIRS : "${libjxl-with-plugins}/share"
          )
        '';
      });

      gnome-control-center = prev'.gnome-control-center.overrideAttrs (old: {
        postInstall = ''
          # Pull in WebP support for gnome-backgrounds.
          # In postInstall to run before gappsWrapperArgsHook.
          export GDK_PIXBUF_MODULE_FILE="${prev'._gdkPixbufCacheBuilder_DO_NOT_USE {
            extraLoaders = with prev; [
              librsvg
              webp-pixbuf-loader
              libjxl-with-plugins
            ];
          }}"
        '';
      });
      gnome-shell = prev'.gnome-shell.overrideAttrs (old: {
        postInstall = ''
          # Pull in WebP support for gnome-backgrounds.
          # In postInstall to run before gappsWrapperArgsHook.
          export GDK_PIXBUF_MODULE_FILE="${prev'._gdkPixbufCacheBuilder_DO_NOT_USE {
          extraLoaders = with prev; [
            librsvg
            webp-pixbuf-loader
            libjxl-with-plugins
          ];
          }}"
        '';
      });
      eog = prev'.eog.overrideAttrs (old: {
        postInstall = ''
          # Pull in WebP and JXL support for gnome-backgrounds.
          # In postInstall to run before gappsWrapperArgsHook.
          export GDK_PIXBUF_MODULE_FILE="${prev'._gdkPixbufCacheBuilder_DO_NOT_USE {
            extraLoaders = with prev; [
              librsvg
              webp-pixbuf-loader
              libheif.out
              libjxl-with-plugins
            ];
          }}"
        '';

        preFixup = with prev; ''
          gappsWrapperArgs+=(
            # Thumbnailers
            --prefix XDG_DATA_DIRS : "${gdk-pixbuf}/share"
            --prefix XDG_DATA_DIRS : "${librsvg}/share"
            --prefix XDG_DATA_DIRS : "${shared-mime-info}/share"
            --prefix XDG_DATA_DIRS : "${libjxl-with-plugins}/share"
          )
        '';
      });
    });
  # })
  # (final: prev: {
  xdg-desktop-portal-gnome = prev.xdg-desktop-portal-gnome.overrideAttrs (old: {
    postInstall = ''
      # Pull in WebP support for gnome-backgrounds.
      # In postInstall to run before gappsWrapperArgsHook.
      export GDK_PIXBUF_MODULE_FILE="${prev.gnome._gdkPixbufCacheBuilder_DO_NOT_USE {
      extraLoaders = with prev;[
      librsvg
      webp-pixbuf-loader
      libjxl-with-plugins
      ];
      }}"
    '';
  });
})
