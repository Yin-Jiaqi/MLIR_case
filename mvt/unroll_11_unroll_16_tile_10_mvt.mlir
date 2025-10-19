#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_mvt(%arg0: i32, %arg1: memref<?xf64>, %arg2: memref<?xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?x2000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %0 step 10 {
      affine.for %arg7 = 0 to %0 step 10 {
        affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%0] {
          affine.for %arg9 = #map(%arg7) to min #map1(%arg7)[%0] {
            %1 = affine.load %arg1[%arg8] : memref<?xf64>
            %2 = affine.load %arg5[%arg8, %arg9] : memref<?x2000xf64>
            %3 = affine.load %arg3[%arg9] : memref<?xf64>
            %4 = arith.mulf %2, %3 : f64
            %5 = arith.addf %1, %4 : f64
            affine.store %5, %arg1[%arg8] : memref<?xf64>
          }
        }
      }
    }
    affine.for %arg6 = 0 to %0 step 10 {
      affine.for %arg7 = 0 to %0 step 10 {
        affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%0] {
          affine.for %arg9 = #map(%arg7) to min #map1(%arg7)[%0] {
            %1 = affine.load %arg2[%arg8] : memref<?xf64>
            %2 = affine.load %arg5[%arg9, %arg8] : memref<?x2000xf64>
            %3 = affine.load %arg4[%arg9] : memref<?xf64>
            %4 = arith.mulf %2, %3 : f64
            %5 = arith.addf %1, %4 : f64
            affine.store %5, %arg2[%arg8] : memref<?xf64>
          }
        }
      }
    }
    return
  }
}

