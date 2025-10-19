#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 62, s0)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_bicg(%arg0: i32, %arg1: i32, %arg2: memref<?x1900xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?xf64>, %arg6: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %0 step 62 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%0] {
        affine.store %cst, %arg3[%arg8] : memref<?xf64>
      }
    }
    %1 = arith.index_cast %arg1 : i32 to index
    affine.for %arg7 = 0 to %1 step 62 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%1] {
        affine.store %cst, %arg4[%arg8] : memref<?xf64>
        affine.for %arg9 = 0 to %0 {
          %2 = affine.load %arg3[%arg9] : memref<?xf64>
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          %4 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg3[%arg9] : memref<?xf64>
          %7 = affine.load %arg4[%arg8] : memref<?xf64>
          %8 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %9 = affine.load %arg5[%arg9] : memref<?xf64>
          %10 = arith.mulf %8, %9 : f64
          %11 = arith.addf %7, %10 : f64
          affine.store %11, %arg4[%arg8] : memref<?xf64>
        }
      }
    }
    return
  }
}

