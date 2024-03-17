use pyo3::prelude::*;
use pyo3::types::IntoPyDict;

fn main() -> PyResult<()> {
    unsafe {
    pyo3::prepare_freethreaded_python();
        Python::with_gil(|py| {
            let fun: Py<PyAny> = PyModule::from_code(
                py,
                "from ctypes import *
def example(*args, **kwargs):
    lib = cdll.LoadLibrary(\"./libffi-example.so\")
    
    lib.example_init()
    
    for x in range(10):
        print(\"Haskell fib(%d): %d\" % (x, lib.fibonacci_hs(x)))
    
    lib.example_exit()",
                "",
                "",
            )?
            .getattr("example")?
            .into();

            // call object without any arguments
            fun.call0(py)?;
    
        Ok(())
    })
    }
}
