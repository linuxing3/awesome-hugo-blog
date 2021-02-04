# 我的博客

记录了折腾编程的一生


## Minimum Hugo version 
Hugo version 0.60.1 or higher is required. View the Hugo releases and download the binary for your OS.

### Installation 

From the root of your site:
```sh
git submodule add https://github.com/zwbetz-gh/cupper-hugo-theme.git themes/cupper-hugo-theme
```
Updating 
From the root of your site:

```sh
git submodule update --remote --merge
```

Run example site 
```sh
From the root of themes/cupper-hugo-theme/exampleSite:
```
hugo server --themesDir ../..
```

### Configuration 
Copy config.yaml from the exampleSite, then edit as desired.