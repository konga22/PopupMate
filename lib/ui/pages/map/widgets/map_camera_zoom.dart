double mapZoomLevelForRadius(double radius) {
  if (radius <= 100) return 16.5;
  if (radius <= 500) return 15.0;
  return 14.0;
}
