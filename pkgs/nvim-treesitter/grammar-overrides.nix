{
  nu = {
    postPatch = ''
      mv queries/nu/* queries/
      rmdir queries/nu
    '';
  };
}
