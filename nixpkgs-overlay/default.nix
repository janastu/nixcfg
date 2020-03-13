self: super: {
  deltachat-electron = self.callPackage ./deltachat-electron { };
  gubbi-font = self.callPackage ./gubbi-font { };
  navilu-font = self.callPackage ./navilu-font { };
}
