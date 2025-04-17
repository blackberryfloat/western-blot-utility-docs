# Quantify an Image

> **NOTE**
> This assumes you have already opened the experiment as outlined in [Open an Experment](./open_an_experiment.md)

To quantify an image you want to select the relevant image in the explorer panel on the left. They are listed under the Data collapsible header. This will open that image for annotation.

## Reference ROI Extrapolation

Currently the application only supports one proprietary Quantification Method called Reference ROI Extrapolation.

> **NOTE**
> This is a hueristic algorithm design for user augmentation not automation. It will not always provide an ideal solution. It works better for clean images that are not skewed and have a clear distinction between background and foreground.

For this method you start by drawing a rectangle around the relevant ROI on the far left. This is handled via a click and drag process. On drag release the rectangle will be solidified and all other ROIs will be guessed. At this point you have full flexibility to resize, move, add, and delete ROIS or you can restart by using the undo pathway. Clear ROIs and Clear Lanes also lets you restart. The right side panel can be used to get a quick snapshot of intensity values per lane / roi and let you label controls.

> **NOTE** Tight reference ROIs tend to provide the best results.

### Resize

All resize operations are global to all ROIs. In the current form, this application does not support independently sized ROIs. At the top of the right side panel are widgets for modifying width and height.

### Move (aka Translate)

To move an ROI you can click hold inside the relevant ROI and drag it around. If you need really fine control over a specific ROI, you can hover over it to get the lane id, and then in the right side panel there are fields within the associated lane header to edit the x and y pixel position of the ROI top left corner.

### Add

You can add an ROI at any time by clicking the image. An new rectangle will be created based on the cursor position.

### Delete

To delete an ROI you can right click on a ROI to open the context menu and then click delete. This will delete the ROI you clicked on. You can also use the delete button but it will only remove the last ROI. If you need to restart, there is a clear ROIs button at the top of the right side panel. It is important to note that deleting an ROI is not the same as deleting a lane. Todelete a lane you must click the clear lanes button in the right side panel or right click on the lane name in the side panel to bring up a context menu and then click remove lane. Lanes and ROIs are handled separately so that Lane Metadata can be populate and preserved as the use manages the ROIs. When ROIs are edited (other than delete), they automatically get remapped to the lanes so the ordered ROIs matches the ordered lanes.

> **WARNING**
> The independent control of ROIs and lanes is intentional but can definitely result in some confusing behavior if not handled carefully. The most likely issue will be useless extra lanes with no ROI being tracked. In this case, it can cause loading controls to be ignored as they wont match the target lane count. The best way to resolve this is to remove the extra lanes when that occurs.
