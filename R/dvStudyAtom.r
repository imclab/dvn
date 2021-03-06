dvStudyAtom <-
function(   objectid, dv=getOption('dvn'), user=getOption('dvn.user'),
            pwd=getOption('dvn.pwd'), browser=FALSE, ...){
    if(is.null(user) | is.null(pwd))
        stop('Must specify username (`user`) and password (`pwd`)')
    xml <- dvDepositQuery(query=paste('edit/study/',objectid,sep=''), user=user, pwd=pwd, dv=dv, browser=browser, ...)
    if(is.null(xml))
        invisible(NULL)
    else if(browser==FALSE)
        .dvParseAtom(xml)
}

.dvParseAtom <- function(xml){
    xmllist <- xmlToList(xml)
    xmlout <- list( bibliographicCitation = xmllist$bibliographicCitation,
                    generator = xmllist$generator,
                    id = xmllist$id)
    xmlout$objectId <- strsplit(xmlout$id,'study/')[[1]][2]
    xmlout$xml <- xml
    class(xmlout) <- c(class(xmlout),'dvStudyAtom')
    return(xmlout)
}

print.dvStudyAtom <- function(x,...){
    cat('Citation:     ',x$bibliographicCitation,'\n')
    cat('ObjectId:     ',x$objectId,'\n')
    cat('Study URI:    ',x$id,'\n')
    cat('Generated by: ',x$generator['uri'],x$generator['version'],'\n')
    invisible(x)
}
