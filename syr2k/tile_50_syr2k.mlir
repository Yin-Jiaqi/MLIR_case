#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 50, s0)>
#map2 = affine_map<(d0) -> (d0 + 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_syr2k(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: f64, %arg4: memref<?x1200xf64>, %arg5: memref<?x1000xf64>, %arg6: memref<?x1000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %1 step 50 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%1] {
        affine.for %arg9 = 0 to #map2(%arg8) {
          %2 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %3 = arith.mulf %2, %arg3 : f64
          affine.store %3, %arg4[%arg8, %arg9] : memref<?x1200xf64>
        }
        affine.for %arg9 = 0 to %0 {
          affine.for %arg10 = 0 to #map2(%arg8) {
            %2 = affine.load %arg5[%arg10, %arg9] : memref<?x1000xf64>
            %3 = arith.mulf %2, %arg2 : f64
            %4 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg6[%arg10, %arg9] : memref<?x1000xf64>
            %7 = arith.mulf %6, %arg2 : f64
            %8 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = arith.addf %5, %9 : f64
            %11 = affine.load %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %12 = arith.addf %11, %10 : f64
            affine.store %12, %arg4[%arg8, %arg10] : memref<?x1200xf64>
          }
        }
      }
    }
    return
  }
}

