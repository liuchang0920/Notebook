// fn main() {
//     let mut x = 4;
//     --x;
//     print!("{}{}", --x, --x);
// }



// quiz 5 不会
// trait Trait {
//     fn p(self);
// }

// impl<T> Trait for fn(T) {
//     fn p(self) {
//         print!("1");
//     }
// }

// impl<T> Trait for fn(&T) {
//     fn p(self) {
//         print!("2");
//     }
// }

// fn f(_: u8) {

// }

// fn g(_:&u8) {

// }

// fn main() {

//     let a: fn(_) = f;
//     let b: fn(_) = g;
//     let c: fn(&_) = g;

//     a.p();
//     b.p();
//     c.p();
// }

// Correct!

// The first impl applies to function pointers of type fn(T) where T is any single concrete type. The second impl applies to function pointers of higher-ranked type for<'a> fn(&'a T) for some concrete type T that outlives 'a.

// Inside of main, the compiler is going to use type inference to substitute all occurrences of _ in a type by some concrete type.

// For the closure a we infer _ = u8, yielding the closure type fn(u8) taking an argument of type u8 and returning ().

// For b we infer _ = &'x u8 for some concrete lifetime 'x that will ultimately feed into the borrow checker. The type of b is fn(&'x u8).

// And finally for c we infer _ = u8, yielding the higher-ranked closure type for<'a> fn(&'a u8).

// Framed in this way, it follows that the trait method calls at the end of main print 112.


// quiz 27 traits, very hard
// trait Base {
//     fn method(&self) {
//         print!("1");
//     }
// }

// trait Derived: Base {
//     fn method(&self) {
//         print!("2");
//     }
// }


// struct  BothTraits;

// impl Base for BothTraits {}
// impl Derived for BothTraits {}

// fn dynamic_dispatch(x: &dyn Base) {
//     x.method();
// }

// fn static_dispatch<T: Base>(x: T) {

//     x.method();
// }

// fn main() {

//     dynamic_dispatch(&BothTraits);
//     static_dispatch(BothTraits);
// }




// quiz 28, when will the variable be garbage collected
// struct Guard;

// impl Drop for Guard {
//     fn drop(&mut self) {
//         print!("1");
//     }
// }

// fn main() {
//     let _guard = Guard;
//     print!("3");
//     let _ = Guard;
//     print!("2");
// }


// quiz 17

// fn main() {

//     let mut a = 5;
//     let mut b =3;

//     print!("{}", a-- - -- b);
// }


// quiz 18, 看不懂。。
// struct S {
//     f: fn(),
// }

// impl S {
//     fn f(&self) {
//         print!("1");
//     }
// }

// fn main() {
//     let print2 = || print!("2");
//    (S { f: print2 }).f();
// }

// quiz 1， macro wtf ??
// macro_rules! m {
//     ($($s:stmt)*) => {
//         $(
//             { stringify!($s); 1 }
//         )<<*
//     };
// }

// fn main() {
//     print!(
//         "{}{}{}",
//         m! { return || true },
//         m! { (return) || true },
//         m! { {return} || true },
//     );
// }


// quiz 19

// struct S;

// impl Drop for S {
//     fn drop(&mut self) {
//         print!("1");
//     }
// }

// fn main() {

//     let s = S;
//     let _ = s;
//     print!("2");
// }


// quiz 21 trait 不是很懂。。
trait Trait {
    fn f(&self);
}

impl<F: FnOnce() -> bool> Trait for F {
    fn f(&self) {
        print!("1");
    }
}

impl Trait for () {
    fn f(&self) {
        print!("2");
    }
}

fn main() {
    let x = || { (return) || true; };
    x().f();

    let x = loop { (break) || true; };
    x.f();

    let x = || { return (|| true); };
    x().f();

    let x = loop { break (|| true); };
    x.f();

    let x = || { return || true; };
    x().f();

    let x = loop { break || true; };
    x.f();
}
