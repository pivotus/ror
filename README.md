Bu şablondan yararlanarak örneğin `foo` adında yeni bir uygulama oluşturmak
isterseniz:

-   Uygulama dizini oluşturarak şablon içeriğini al

    ```sh
    $ mkdir foo
    $ cd foo
    $ wget -qO- https://github.com/pivotus/ror/archive/master.tar.gz | tar --strip-components=1 -zxvf -
    ```

-   Uygulama ismini değiştir

    ```sh
    $ find ./ -type f -readable -writable -exec sed -i "s/\bRor\b/Foo/g" {} \;
    ```

-   Depoyu ilkle

    ```sh
    $ git init
    $ git add .
    $ git commit -a -m .
    ```

-   Github'ta `foo` adında yeni bir depo oluştur

-   Github'a gönder

    ```sh
    $ git remote add origin https://github.com/pivotus/foo.git
    $ git push -u origin master
    ```
