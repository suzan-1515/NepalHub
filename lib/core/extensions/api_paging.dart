const int PAGE_SIZE = 20;

extension APIPagingX on int {
  int get start => (this * PAGE_SIZE) - PAGE_SIZE;
  int get limit => PAGE_SIZE;
}
