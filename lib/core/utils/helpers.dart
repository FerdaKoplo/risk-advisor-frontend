class RiskHelper {
  static String getCategory(int risk) {
    if (risk < 40) return "Rendah";
    if (risk < 70) return "Sedang";
    return "Tinggi";
  }
}
