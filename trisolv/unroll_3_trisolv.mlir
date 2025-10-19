#map = affine_map<(d0) -> ((d0 floordiv 3) * 3)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_trisolv(%arg0: i32, %arg1: memref<?x2000xf64>, %arg2: memref<?xf64>, %arg3: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %0 {
      %1 = affine.load %arg3[%arg4] : memref<?xf64>
      affine.store %1, %arg2[%arg4] : memref<?xf64>
      affine.for %arg5 = 0 to #map(%arg4) step 3 {
        %5 = affine.load %arg1[%arg4, %arg5] : memref<?x2000xf64>
        %6 = affine.load %arg2[%arg5] : memref<?xf64>
        %7 = arith.mulf %5, %6 : f64
        %8 = affine.load %arg2[%arg4] : memref<?xf64>
        %9 = arith.subf %8, %7 : f64
        affine.store %9, %arg2[%arg4] : memref<?xf64>
        %10 = affine.apply #map1(%arg5)
        %11 = affine.load %arg1[%arg4, %10] : memref<?x2000xf64>
        %12 = affine.load %arg2[%10] : memref<?xf64>
        %13 = arith.mulf %11, %12 : f64
        %14 = affine.load %arg2[%arg4] : memref<?xf64>
        %15 = arith.subf %14, %13 : f64
        affine.store %15, %arg2[%arg4] : memref<?xf64>
        %16 = affine.apply #map2(%arg5)
        %17 = affine.load %arg1[%arg4, %16] : memref<?x2000xf64>
        %18 = affine.load %arg2[%16] : memref<?xf64>
        %19 = arith.mulf %17, %18 : f64
        %20 = affine.load %arg2[%arg4] : memref<?xf64>
        %21 = arith.subf %20, %19 : f64
        affine.store %21, %arg2[%arg4] : memref<?xf64>
      }
      affine.for %arg5 = #map(%arg4) to #map3(%arg4) {
        %5 = affine.load %arg1[%arg4, %arg5] : memref<?x2000xf64>
        %6 = affine.load %arg2[%arg5] : memref<?xf64>
        %7 = arith.mulf %5, %6 : f64
        %8 = affine.load %arg2[%arg4] : memref<?xf64>
        %9 = arith.subf %8, %7 : f64
        affine.store %9, %arg2[%arg4] : memref<?xf64>
      }
      %2 = affine.load %arg2[%arg4] : memref<?xf64>
      %3 = affine.load %arg1[%arg4, %arg4] : memref<?x2000xf64>
      %4 = arith.divf %2, %3 : f64
      affine.store %4, %arg2[%arg4] : memref<?xf64>
    }
    return
  }
}

