# Usage Instructions

## Key Terminology

| Name | Description |
| :- | :- |
| Experiment | A project that explores the impact of a combination of compounds and doses on substances in order to gain insight into the viability of a compound for drug use. For this application, an experiment is represented by a folder on the file system. Typically this is a folder of images.|
| Image | An image is the digital scan of an optimal exposure capture of a blot stained with a specific antibody. |
| Lane | This represents a singular case that contains unique set of independent variable such as a drug type, dose, and time factor.|
| Region of Interest (ROI) | The specific rectangle of pixels within an image and lane that represents the effectiveness of a case. Intensity calculations are made based on this item. |

## Opening an Experiment

The process for opening an Experiment or creating a new one is the same.
1. open the file menu
1. click open
1. select a folder containing the images you want to process

> **NOTE**
> A file with the .wbu extension will be created in said folder. This file contains the application state information for that experiment. It is a JSON object meaning it is human readable if you want to inspect it. It is strongly encouraged you do NOT modify it though as this could result in issues for the application next time it is loaded.

## Managing an Experiment

To quantify an image you want to select the relevant image in the explorer panel on the left. They are listed under the Data collapsible header. This will open that image for annotation.

### Reference ROI Extrapolation

Currently the application only supports one proprietary Quantification Method called Reference ROI Extrapolation.

> **NOTE**
> This is a hueristic algorithm design for user augmentation not automation. It will not always provide an ideal solution. It works better for clean images that are not skewed and have a clear distinction between background and foreground.

For this method you start by drawing a rectangle around the relevant ROI on the far left. This is handled via a click and drag process. On drag release the rectangle will be solidified and all other ROIs will be guessed. At this point you have full flexibility to resize, move, add, and delete ROIS or you can restart by using the undo pathway. Clear ROIs and Clear Lanes also lets you restart. The right side panel can be used to get a quick snapshot of intensity values per lane / roi and let you label controls.

> **NOTE** Tight reference ROIs tend to provide the best results.

All resize operations are global to all ROIs. In the current form, this application does not support independently sized ROIs. At the top of the right side panel are widgets for modifying width and height.

To move an ROI you can click hold inside the relevant ROI and drag it around. If you need really fine control over a specific ROI, you can hover over it to get the lane id, and then in the right side panel there are fields within the associated lane header to edit the x and y pixel position of the ROI top left corner.

You can add an ROI at any time by clicking the image. An new rectangle will be created based on the cursor position.

To delete an ROI you can right click on a ROI to open the context menu and then click delete. This will delete the ROI you clicked on. You can also use the delete button but it will only remove the last ROI. If you need to restart, there is a clear ROIs button at the top of the right side panel. It is important to note that deleting an ROI is not the same as deleting a lane. Todelete a lane you must click the clear lanes button in the right side panel or right click on the lane name in the side panel to bring up a context menu and then click remove lane. Lanes and ROIs are handled separately so that Lane Metadata can be populate and preserved as the use manages the ROIs. When ROIs are edited (other than delete), they automatically get remapped to the lanes so the ordered ROIs matches the ordered lanes.

> **WARNING**
> The independent control of ROIs and lanes is intentional but can definitely result in some confusing behavior if not handled carefully. The most likely issue will be useless extra lanes with no ROI being tracked. In this case, it can cause loading controls to be ignored as they wont match the target lane count. The best way to resolve this is to remove the extra lanes when that occurs.

## Audit

Due to the nature of what this tool is intended for, an audit feature is provided. This feature is a per image CSV export gives a user full transparency into the calculations that are happening for each ROI behind the scenes. It gives users complete access to the raw values so they can reproduce the calculations by hand.

1. open the file menu
1. click audit image
1. select an output location for the CSV

## Exports

This application allows you to export the calculated intensities for this experiment to a CSV. Currently you can select from summed, average, and normalized. Summed is recommended if you have no controls and normalized is recommended if you labeled your controls. The normalized value will be calculated if you provide any combination of a loading control, internal control, or both. If there are no controls, you will get an empty CSV.

1. open the file menu
1. click export
1. select the relevant export method (ie normalized)
1. select an output location in the file dialog

## Keyboard Shortcuts

| Shortcut | Action |
| :- | :- |
| Ctrl+Z | Undo |
| Ctrl+Shift+Z | Redo |
| Del | If there is at least one ROI on the current image, remove the last one in the list. | 

## Submit Feedback

Feedback is strongly encouraged and welcome. You can submit feedback [here](https://github.com/blackberryfloat/western-blot-utility-docs/issues).

