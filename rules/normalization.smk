# Copyright 2018 Johannes Köster.
# Licensed under the MIT license (http://opensource.org/licenses/MIT)
# This file may not be copied, modified, or distributed
# except according to those terms.


rule normalize:
    input:
        "analysis/filtered.rds"
    output:
        rds="analysis/normalized.rds",
        scatter=report("plots/size-factors-vs-libsize.svg",
                       caption="../report/size-factors.rst",
                       category="Normalization")
    log:
        "logs/normalize.log"
    conda:
        "../envs/eval.yaml"
    script:
        "../scripts/normalize.R"



rule batch_effect_removal:
    input:
        sce="analysis/normalized.rds",
        cycles="analysis/cell-cycle-assignments.rds"
    output:
        design_matrix="analysis/design-matrix.rds",
        sce="analysis/normalized.batch-removed.rds"
    params:
        model_variables=config["model"]["variables"]
    log:
        "logs/batch-effect-removal.log"
    conda:
        "../envs/eval.yaml"
    script:
        "../scripts/batch-effect-removal.R"
