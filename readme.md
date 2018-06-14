1. create backend.nix
2. create update-requirements
3. run update-requirements
4. update requirements_override.nix and update-requirements to fix shit broken in base package (dependencies, cycles, wrong version numbers, patches etc, missing system dependencies)
5. nix-build backend.nix (iterate 3-5 until shit is less broken, when your app is good and all dependencies are reasonable, 3-4 don't exist))
6. ./result/bin/start - WORKS, we have nix self contained nix package

dockerizing


