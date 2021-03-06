value2col <-
    function(dat, position.legend, palette, range, border.col, fontfamily.legend, auto.col.mapping) {
        maxlev <- max(dat$l)
        
        #browser()
        
        values_all <- dat$c
        values <- values_all[dat$l==maxlev]

        
        if (any(is.na(range))) {
            prettyV <- pretty(values, n=8)
            
            mx <- max(abs(c(values, prettyV)))
            
            value.ids <- round((values_all / mx * 50) + 51)
            prettyV.ids <- round((prettyV / mx * 50) + 51)
            
        } else {
            if (any(values < range[1]) || any(values > range[2])) warning("Values are found that exceed the provided range")
            
            prettyV <- pretty(range, n=8)
            prettyV <- prettyV[prettyV>=range[1] & prettyV<=range[2]]
            
            
            if (auto.col.mapping) {
                mx <- max(abs(prettyV))
                
                value.ids <- round((values_all / mx * 50) + 51)
                prettyV.ids <- round((prettyV / mx * 50) + 51)
            } else {
                diff <- range[2] - range[1]
                value.ids <- round(((values_all - range[1]) /  diff) * 100 + 1)
                prettyV.ids <- round(((prettyV - range[1]) /  diff) * 100 + 1)
            }
        }
        
        value.ids[value.ids < 1] <- 1
        value.ids[value.ids > 101] <- 101
        
            
        colpal <- colorRampPalette(palette)(101)
        
        if (position.legend!="none") drawLegend(format(prettyV), colpal[prettyV.ids], position.legend=="bottom", border.col, fontfamily.legend)
        
        return (list(colpal[value.ids], range(prettyV), values_all))
    }
