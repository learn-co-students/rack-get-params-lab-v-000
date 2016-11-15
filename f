
[1mFrom:[0m /home/wstory-20951/code/labs/rack-get-params-lab-v-000/app/application.rb @ line 24 Application#call:

     [1;34m7[0m: [32mdef[0m [1;34mcall[0m(env)
     [1;34m8[0m:   resp = [1;34;4mRack[0m::[1;34;4mResponse[0m.new
     [1;34m9[0m:   req = [1;34;4mRack[0m::[1;34;4mRequest[0m.new(env)
    [1;34m10[0m: 
    [1;34m11[0m:   [32mif[0m req.path.match([35m[1;35m/[0m[35mitems[1;35m/[0m[35m[0m)
    [1;34m12[0m:     [36m@@items[0m.each [32mdo[0m |item|
    [1;34m13[0m:       resp.write [31m[1;31m"[0m[31m#{item}[0m[31m[1;35m\n[0m[31m[1;31m"[0m[31m[0m
    [1;34m14[0m:     [32mend[0m
    [1;34m15[0m:   [32melsif[0m req.path.match([35m[1;35m/[0m[35mcart[1;35m/[0m[35m[0m)
    [1;34m16[0m:     [32mif[0m [36m@@cart[0m == []
    [1;34m17[0m:       resp.write [31m[1;31m"[0m[31mYour cart is empty[1;31m"[0m[31m[0m
    [1;34m18[0m:     [32melse[0m
    [1;34m19[0m:       [36m@@cart[0m.each [32mdo[0m |item|
    [1;34m20[0m:         resp.write [31m[1;31m"[0m[31m#{item}[0m[31m[1;35m\n[0m[31m[1;31m"[0m[31m[0m
    [1;34m21[0m:       [32mend[0m
    [1;34m22[0m:     [32mend[0m
    [1;34m23[0m:   [32melsif[0m req.path.match([35m[1;35m/[0m[35madd[1;35m/[0m[35m[0m)
 => [1;34m24[0m:     binding.pry
    [1;34m25[0m:     item = req.params
    [1;34m26[0m:     resp.write add_item(item)
    [1;34m27[0m:   [32melsif[0m req.path.match([35m[1;35m/[0m[35msearch[1;35m/[0m[35m[0m)
    [1;34m28[0m:     search_term = req.params[[31m[1;31m"[0m[31mq[1;31m"[0m[31m[0m]
    [1;34m29[0m:     resp.write handle_search(search_term)
    [1;34m30[0m:   [32melse[0m
    [1;34m31[0m:     resp.write [31m[1;31m"[0m[31mPath Not Found[1;31m"[0m[31m[0m
    [1;34m32[0m:   [32mend[0m
    [1;34m33[0m:   resp.finish
    [1;34m34[0m: [32mend[0m

