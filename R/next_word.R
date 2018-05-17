#' Ngram Model to predict next word
#' We built and train three ngram to check what will be the next word, we check first with the last 3 words,
#' if nothing is found, the last two and so the last. If there is no match, the word the most used is returned.
#' @param str1 a sentence or word, just the maximum last three words will be in the process.
#' @return the five word with the higher frequency following the precedents words.
#' @author Aurelien Roussille
#' @details
#' This function is the last test for the data science coursera course of Hopkins university
#' @seealso \code{filter, tolower,str_split}
#' @export
#' @importFrom dplyr stringr



next_word<-function(str1){

     if (requireNamespace("dplyr", quietly = TRUE) & requireNamespace("stringr", quietly = TRUE)) {

     } else {
          stop("dplyr and stringr are missing")
     }

    #suppressMessages(suppressWarnings(library(dplyr)))
    #suppressMessages(suppressWarnings(library(stringr)))
    str1<-tolower(str1)

    m1<-""
    m2<-""
    m3<-""
    load("~/NxT/R/sysdata.rda")
    temp<-stringr::str_split(str1," ")
    #df1<-read.csv("ngram1.csv",sep = ",",header = TRUE)
    #df2<-read.csv("ngram2.csv",sep = ",",header = TRUE)
    #df3<-read.csv("ngram3.csv",sep = ",",header = TRUE)
    #df4<-read.csv("ngram4.csv",sep = ",",header = TRUE)

    #df1<-df1[order(df1$frequency,decreasing=TRUE),]
    #df2<-df2[order(df2$frequency,decreasing=TRUE),]
    #df3<-df3[order(df3$frequency,decreasing=TRUE),]
    #df4<-df4[order(df4$frequency,decreasing=TRUE),]

    #df1$feature<-as.character(df1$feature)

    #df2$W1<-as.character(df2$W1)
    #df2$W2<-as.character(df2$W2)

    #df3$W1<-as.character(df3$W1)
    #df3$W2<-as.character(df3$W2)
    #df3$W3<-as.character(df3$W3)

    #df4$W1<-as.character(df4$W1)
    #df4$W2<-as.character(df4$W2)
    #df4$W3<-as.character(df4$W3)
    #df4$W4<-as.character(df4$W4)

    temp<-temp[[1]]

    if (length(temp)==1){
        affiche<-head(dplyr::filter(df2,W1==temp[1]),5)
        affiche<-affiche$W2
        m1<-"ok"
    } else {
        if (length(temp)==2){
            affiche2<-head(dplyr::filter(df3,W1==temp[1],W2==temp[2]),5)
            affiche2<-affiche2$W3
            if (length(affiche2)==0){
                affiche2<-head(dplyr::filter(df2,W1==tempo[2]),5)
                affiche2<-affiche2$W2
            }
            m2<-"ok"
        } else{
            tempo<-tail(temp,3)
            affiche3<-head(dplyr::filter(df4,W1==tempo[1],W2==tempo[2],
                                  W3==tempo[3]),5)
            affiche3<-affiche3$W4
            if (length(affiche3)==0){
                affiche3<-head(dplyr::filter(df3,W1==tempo[2],W2==tempo[3]),5)
                affiche3<-affiche3$W3
            }
            if (length(affiche3)==0){
                affiche3<-head(dplyr::filter(df2,W1==tempo[3]),5)
                affiche3<-affiche3$W2
            }
            m3<-"ok"
        }
    }

    if (m3=="ok"){
        affiche3
    } else {
        if (m2=="ok" ){
            affiche2
        } else {
            if (m1=="ok"){
                affiche
            } else {
                df1$feature[1:5]
            }
        }
    }
}
