#map = affine_map<(d0) -> (d0 + 1)>
#map1 = affine_map<(d0)[s0] -> (d0 + (((-d0 + s0 - 1) floordiv 2) floordiv 2) * 4 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0)[s0] -> (d0 + ((-d0 + s0 - 1) floordiv 2) * 2 + 1)>
#map4 = affine_map<(d0)[s0] -> (d0 + ((-d0 + s0 - 1) floordiv 2) * 2 + ((-d0 + s0 - ((-d0 + s0 - 1) floordiv 2) * 2 - 1) floordiv 2) * 2 + 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_trmm(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: memref<?x1000xf64>, %arg4: memref<?x1200xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg5 = 0 to %1 {
      affine.for %arg6 = 0 to %0 {
        affine.for %arg7 = #map(%arg5) to #map1(%arg5)[%1] step 4 {
          %4 = affine.load %arg3[%arg7, %arg5] : memref<?x1000xf64>
          %5 = affine.load %arg4[%arg7, %arg6] : memref<?x1200xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %8 = arith.addf %7, %6 : f64
          affine.store %8, %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %9 = affine.apply #map(%arg7)
          %10 = affine.load %arg3[%9, %arg5] : memref<?x1000xf64>
          %11 = affine.load %arg4[%9, %arg6] : memref<?x1200xf64>
          %12 = arith.mulf %10, %11 : f64
          %13 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %14 = arith.addf %13, %12 : f64
          affine.store %14, %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %15 = affine.apply #map2(%arg7)
          %16 = affine.load %arg3[%15, %arg5] : memref<?x1000xf64>
          %17 = affine.load %arg4[%15, %arg6] : memref<?x1200xf64>
          %18 = arith.mulf %16, %17 : f64
          %19 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %20 = arith.addf %19, %18 : f64
          affine.store %20, %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %21 = affine.apply #map(%15)
          %22 = affine.load %arg3[%21, %arg5] : memref<?x1000xf64>
          %23 = affine.load %arg4[%21, %arg6] : memref<?x1200xf64>
          %24 = arith.mulf %22, %23 : f64
          %25 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %26 = arith.addf %25, %24 : f64
          affine.store %26, %arg4[%arg5, %arg6] : memref<?x1200xf64>
        }
        affine.for %arg7 = #map1(%arg5)[%1] to #map3(%arg5)[%1] step 2 {
          %4 = affine.load %arg3[%arg7, %arg5] : memref<?x1000xf64>
          %5 = affine.load %arg4[%arg7, %arg6] : memref<?x1200xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %8 = arith.addf %7, %6 : f64
          affine.store %8, %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %9 = affine.apply #map(%arg7)
          %10 = affine.load %arg3[%9, %arg5] : memref<?x1000xf64>
          %11 = affine.load %arg4[%9, %arg6] : memref<?x1200xf64>
          %12 = arith.mulf %10, %11 : f64
          %13 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %14 = arith.addf %13, %12 : f64
          affine.store %14, %arg4[%arg5, %arg6] : memref<?x1200xf64>
        }
        affine.for %arg7 = #map3(%arg5)[%1] to #map4(%arg5)[%1] step 2 {
          %4 = affine.load %arg3[%arg7, %arg5] : memref<?x1000xf64>
          %5 = affine.load %arg4[%arg7, %arg6] : memref<?x1200xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %8 = arith.addf %7, %6 : f64
          affine.store %8, %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %9 = affine.apply #map(%arg7)
          %10 = affine.load %arg3[%9, %arg5] : memref<?x1000xf64>
          %11 = affine.load %arg4[%9, %arg6] : memref<?x1200xf64>
          %12 = arith.mulf %10, %11 : f64
          %13 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %14 = arith.addf %13, %12 : f64
          affine.store %14, %arg4[%arg5, %arg6] : memref<?x1200xf64>
        }
        affine.for %arg7 = #map4(%arg5)[%1] to %1 {
          %4 = affine.load %arg3[%arg7, %arg5] : memref<?x1000xf64>
          %5 = affine.load %arg4[%arg7, %arg6] : memref<?x1200xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
          %8 = arith.addf %7, %6 : f64
          affine.store %8, %arg4[%arg5, %arg6] : memref<?x1200xf64>
        }
        %2 = affine.load %arg4[%arg5, %arg6] : memref<?x1200xf64>
        %3 = arith.mulf %arg2, %2 : f64
        affine.store %3, %arg4[%arg5, %arg6] : memref<?x1200xf64>
      }
    }
    return
  }
}

