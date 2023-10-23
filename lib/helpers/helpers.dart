String truncateText(String text, int length) {
  return text.length > length ? '${text.substring(0, length)}...' : text;
}
