count = 0
foo = true
foo = catch(1) do
  p [:foo, foo, count]
  count += 1
  bar = catch(2) do
    baz = catch(3) do
      throw(1, true)
    end
  end
end while foo && count < 10
