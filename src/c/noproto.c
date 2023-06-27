int func (p, p2)
    void* p;
    int  p2;
{
    return 0;
}

void foo(int i);
void bar(char *a, double b);
void baz(void);

int main()
{
  void (*fn[])() = { foo, bar, baz };
  fn[0](5);
  fn[1]("abc", 1.0);
  fn[2]();
}